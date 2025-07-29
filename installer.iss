[Setup]
AppName=Smart Rename
AppVersion=1.0
DefaultDirName={pf}\SmartRename
DefaultGroupName=Smart Rename
OutputDir=.
OutputBaseFilename=SmartRenameInstaller
Compression=lzma
SolidCompression=yes

[Files]
Source: "dist\image_renamer.exe"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\Smart Rename"; Filename: "{app}\image_renamer.exe"
Name: "{group}\Uninstall Smart Rename"; Filename: "{uninstallexe}"

[Registry]
; JPG
Root: HKCR; Subkey: "SystemFileAssociations\.jpg\shell\SmartRename"; ValueType: string; ValueName: ""; ValueData: "Smart Rename with AI"
Root: HKCR; Subkey: "SystemFileAssociations\.jpg\shell\SmartRename\command"; ValueType: string; ValueData: """{app}\image_renamer.exe"" ""%1"""
; PNG
Root: HKCR; Subkey: "SystemFileAssociations\.png\shell\SmartRename"; ValueType: string; ValueName: ""; ValueData: "Smart Rename with AI"
Root: HKCR; Subkey: "SystemFileAssociations\.png\shell\SmartRename\command"; ValueType: string; ValueData: """{app}\image_renamer.exe"" ""%1"""
; JPEG
Root: HKCR; Subkey: "SystemFileAssociations\.jpeg\shell\SmartRename"; ValueType: string; ValueName: ""; ValueData: "Smart Rename with AI"
Root: HKCR; Subkey: "SystemFileAssociations\.jpeg\shell\SmartRename\command"; ValueType: string; ValueData: """{app}\image_renamer.exe"" ""%1"""
; WEBP
Root: HKCR; Subkey: "SystemFileAssociations\.webp\shell\SmartRename"; ValueType: string; ValueName: ""; ValueData: "Smart Rename with AI"
Root: HKCR; Subkey: "SystemFileAssociations\.webp\shell\SmartRename\command"; ValueType: string; ValueData: """{app}\image_renamer.exe"" ""%1"""
; BMP
Root: HKCR; Subkey: "SystemFileAssociations\.bmp\shell\SmartRename"; ValueType: string; ValueName: ""; ValueData: "Smart Rename with AI"
Root: HKCR; Subkey: "SystemFileAssociations\.bmp\shell\SmartRename\command"; ValueType: string; ValueData: """{app}\image_renamer.exe"" ""%1"""
; TIFF
Root: HKCR; Subkey: "SystemFileAssociations\.tif\shell\SmartRename"; ValueType: string; ValueName: ""; ValueData: "Smart Rename with AI"
Root: HKCR; Subkey: "SystemFileAssociations\.tif\shell\SmartRename\command"; ValueType: string; ValueData: """{app}\image_renamer.exe"" ""%1"""
Root: HKCR; Subkey: "SystemFileAssociations\.tiff\shell\SmartRename"; ValueType: string; ValueName: ""; ValueData: "Smart Rename with AI"
Root: HKCR; Subkey: "SystemFileAssociations\.tiff\shell\SmartRename\command"; ValueType: string; ValueData: """{app}\image_renamer.exe"" ""%1"""

[UninstallRun]
Filename: "reg"; Parameters: "delete HKCR\SystemFileAssociations\.jpg\shell\SmartRename /f"; Flags: runhidden
Filename: "reg"; Parameters: "delete HKCR\SystemFileAssociations\.png\shell\SmartRename /f"; Flags: runhidden
Filename: "reg"; Parameters: "delete HKCR\SystemFileAssociations\.jpeg\shell\SmartRename /f"; Flags: runhidden
Filename: "reg"; Parameters: "delete HKCR\SystemFileAssociations\.webp\shell\SmartRename /f"; Flags: runhidden
Filename: "reg"; Parameters: "delete HKCR\SystemFileAssociations\.bmp\shell\SmartRename /f"; Flags: runhidden
Filename: "reg"; Parameters: "delete HKCR\SystemFileAssociations\.tif\shell\SmartRename /f"; Flags: runhidden
Filename: "reg"; Parameters: "delete HKCR\SystemFileAssociations\.tiff\shell\SmartRename /f"; Flags: runhidden


[Run]
Filename: "{app}\image_renamer.exe"; Description: "Run Smart Rename"; Flags: nowait postinstall skipifsilent
