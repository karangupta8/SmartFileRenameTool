
# 🖼️ Smart Image Renamer


A powerful tool that lets you **automatically rename image files based on their content**, using a pretrained image classification model. It integrates seamlessly with the Windows context menu for quick access.

---

## 📑 Table of Contents

- [About](#-about)
- [Problem](#-problem)
- [Goal](#-goal)
- [Features](#-features)
- [Demo](#-demo)
- [Installation](#-installation)
- [Usage](#-usage)
- [Project Structure](#-project-structure)
- [Documentation](#-documentation)
- [Technical Details](#-technical-details)
- [Workflow Overview](#-workflow-overview)
- [Tech Stack](#-tech-stack)
- [Model Requirements](#-model-requirements)
- [Contributing](#-contributing)
- [Roadmap](#-roadmap)
- [License](#-license)
- [Author](#-author)


---

## ✅ Problem

When images are downloaded from the web, they are often named arbitrarily (e.g., `image123.jpg`, `random123.png`), making them hard to search or organize.


## 🎯 Goal

Create a **Windows desktop application** that:
- Takes an image as input.
- Uses a lightweight open-source ML model to **analyze image content**.
- Suggests a meaningful filename based on the image (e.g., `sunset-beach.jpg`, `cat-sitting-sofa.jpg`).
- Saves or renames the file with the generated name.
- Embed into Windows Explorer Right-Click Menu (Context Menu)
- Run as background service monitoring "Downloads" folder.


## Inspiration

This Meme:

![InspirationMeme](assets/InspirationMeme.png)

---

## ✨ Features

- 🔍 Uses AI to **identify image content** and rename accordingly.
- 🖱️ **Right-click menu integration** for easy access from Windows Explorer.
- 🛠️ **Offline support** - no internet needed to rename images.

---

## 🎥 Demo

> Coming soon...

![Demo Screenshot](assets/demo.jpg)

---

## ⚙ Installation

To install **Smart Image Renamer**:

1. Download the latest `ImageRenamerSetup.exe` from [Releases](https://github.com/yourusername/image-renamer/releases).
2. Run the installer. It will:
   - Copy required files to the install directory.
   - Register right-click context menu entries for image files.
3. Use "Uninstall Image Renamer" from the Start Menu to remove.

> **Note:** Requires Python 3.9+ if running from source.

---

## 🚀 Usage

After installation, just **right-click any `.jpg`, `.png`, `.jpeg`, etc.**, and select:

> 🖼️ Smart Rename with AI

To run from source:

```bash
python image_renamer.py path\to\images\
````

---

## 🗂 Project Structure

```bash
image-renamer/
├── image_renamer.py            # Main logic
├── imagenet_classes.txt        # Label map for predictions
├── installer.iss               # Inno Setup script
├── SmartRenameInstaller.exe    # Installer file by Inno Setup
├── build.bat                   # PyInstaller + EXE creation
├── README.md                   # This file
└── assets/                     # Icons and demo images
```

---

## 📚 Documentation

* **Model:** ResNet18 pretrained on ImageNet (from `torchvision.models`)
* **Prediction flow:** image → preprocessing → model → label → renaming
* **Installer:** built with `Inno Setup`, adds right-click handlers via registry
* **EXE Packaging:** via `pyinstaller --onefile --add-data`

---


## 🧠 Technical Details

This project is a **Python-based file renaming utility** that uses **image classification** to auto-suggest tags for images and rename them accordingly.

### 🏗 Workflow Overview

1. **User Action**:

   * Right-click an image → Select “Rename with Tags”.
   * Tool launches silently or in CLI (depending on build), takes image path as input.

2. **Image Processing**:

   * The image is passed through a lightweight image classification model (`torchvision.models.squeezenet1_1`).
   * The model returns the **top 5 predicted class labels** using pretrained weights on **ImageNet**.

3. **Renaming Logic**:

   * The original filename is updated with the predicted tags.
   * New format: `originalfilename-tag1-tag2-tag3.jpg`.

4. **Packaging**:

   * The project is bundled into a standalone `.exe` using `pyinstaller`.
   * The ImageNet labels file (`imagenet_classes.txt`) is embedded into the executable using the `--add-data` option.
   * An installer is generated using **Inno Setup**, with optional uninstaller support.

5. **Silent Logging**:

   * Logs of all renamed files and errors are stored in a `logs/` directory next to the executable.


### 📦 Tech Stack

* **Language**: Python 3.11+
* **ML Model**: `torchvision.models.squeezenet1_1`
* **Packaging Tool**: PyInstaller
* **Installer**: Inno Setup Script (.iss)
* **Silent Execution**: Supports CLI invocation without UI


## 🧠 Model Requirements

- **Small in size** (can be bundled with the app, works offline).
- **Fast inference** on CPU (no GPU dependency).
- **Decent image captioning** ability (for naming).

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repo.
2. Create a branch: `git checkout -b feature-name`
3. Commit changes with clear messages.
4. Submit a PR with description and screenshots if relevant.

---

## 🛣 Roadmap

* [x] Add support for JPG, PNG, WEBP, BMP
* [ ] Drag & drop UI
* [ ] Batch renaming preview window
* [ ] Mac/Linux versions
* [ ] Custom model support

---

## 📜 License

Distributed under the [MIT License](LICENSE).

---

## 👤 Author

**Karan Gupta**
