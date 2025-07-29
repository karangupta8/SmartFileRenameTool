import os
import sys
import datetime
import torch
from PIL import Image
from datetime import datetime
from torchvision import models, transforms


# Ensure logs directory exists
log_dir = os.path.join(os.path.dirname(__file__), "logs")
os.makedirs(log_dir, exist_ok=True)

# Create log file with timestamp
log_file = os.path.join(log_dir, f"log_{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.txt")

# Redirect stdout and stderr to log file
sys.stdout = open(log_file, "w", encoding="utf-8")
sys.stderr = sys.stdout

for filename in os.listdir(log_dir):
    filepath = os.path.join(log_dir, filename)
    if os.path.isfile(filepath):
        file_age = time.time() - os.path.getmtime(filepath)
        if file_age > 7 * 86400:  # 7 days
            os.remove(filepath)

# -------- Runtime Path Handling for PyInstaller --------
def get_resource_path(relative_path):
    try:
        base_path = sys._MEIPASS  # PyInstaller extracts files here
    except Exception:
        base_path = os.path.abspath(".")
    return os.path.join(base_path, relative_path)

# -------- Load Labels --------
def load_labels():
    labels_path = get_resource_path("imagenet_classes.txt")
    with open(labels_path, "r", encoding="utf-8") as f:
        return [line.strip() for line in f.readlines()]

imagenet_labels = load_labels()

# -------- File Types --------
SUPPORTED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".bmp", ".gif", ".webp", ".tiff"}

# -------- Model --------
model = models.resnet18(weights=models.ResNet18_Weights.DEFAULT)
model.eval()

# -------- Preprocessing --------
preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(
        mean=[0.485, 0.456, 0.406],
        std=[0.229, 0.224, 0.225],
    ),
])

# -------- Logging --------
def log(message: str):
    log_file = os.path.join(os.path.expanduser("~"), "smart_rename_log.txt")
    with open(log_file, "a", encoding="utf-8") as f:
        f.write(f"[{datetime.now()}] {message}\n")

# -------- Predict Top-k Labels --------
def get_labels(image_path: str, topk: int = 3) -> list[str]:
    try:
        image = Image.open(image_path).convert("RGB")
        input_tensor = preprocess(image).unsqueeze(0)
        with torch.no_grad():
            output = model(input_tensor)
            _, predicted_indices = torch.topk(output, topk)
            return [imagenet_labels[idx] for idx in predicted_indices[0]]
    except Exception as e:
        log(f"Error processing {image_path}: {str(e)}")
        raise


# -------- Format Multiple Labels into Filename --------
def labels_to_filename(labels: list[str], ext: str) -> str:
    clean_labels = [
        "".join(c for c in label.lower().replace(" ", "-") if c.isalnum() or c in ["-", "_"])
        for label in labels
    ]
    base_name = "-".join(clean_labels)
    return base_name + ext.lower()

# -------- Rename with Multiple Tags --------
def rename_image(image_path: str):
    ext = os.path.splitext(image_path)[1].lower()
    if ext not in SUPPORTED_EXTENSIONS:
        log(f"Skipped unsupported file: {image_path}")
        return

    try:
        labels = get_labels(image_path, topk=3)
        new_name = labels_to_filename(labels, ext)
        dir_path = os.path.dirname(image_path)
        new_path = os.path.join(dir_path, new_name)

        # Avoid overwriting
        base, _ = os.path.splitext(new_path)
        counter = 1
        while os.path.exists(new_path):
            new_path = f"{base}_{counter}{ext}"
            counter += 1

        os.rename(image_path, new_path)
        log(f"Renamed '{image_path}' → '{new_path}'")

    except Exception as e:
        log(f"Failed to rename {image_path}: {e}")


# -------- Entry Point --------
    if __name__ == "__main__":
     if len(sys.argv) >= 2:
        image_file = sys.argv[1].strip('"')
        if os.path.isfile(image_file):
            rename_image(image_file)
 

# -------- For Local Testing --------
""" if __name__ == "__main__":
    import sys
    if len(sys.argv) < 2:
        test_image = "C:\\Users\\k\\Downloads\\download - Copy.png"  # replace with your actual test file name
        rename_image(test_image)
    else:
        rename_image(sys.argv[1]) """