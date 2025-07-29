@echo off
setlocal enabledelayedexpansion

REM --------- CONFIG ---------
set SCRIPT=image_renamer.py
set DATA=imagenet_classes.txt
set LOG=build_log.txt
set EXENAME=image_renamer.exe
set OUTDIR=dist

REM --------- CLEAN OLD BUILDS ---------
echo Cleaning up previous builds...
rmdir /s /q build 2>nul
rmdir /s /q %OUTDIR% 2>nul
del %SCRIPT:.py=.spec% 2>nul
del %LOG% 2>nul

REM --------- INSTALL PYINSTALLER ---------
echo Installing PyInstaller... >> %LOG%
python -m pip install pyinstaller >> %LOG% 2>&1

REM --------- BUILD EXE ---------
echo Building executable...
python -m PyInstaller --noconfirm --onefile --windowed --add-data "%DATA%;." %SCRIPT% >> %LOG% 2>&1

REM --------- POST-BUILD ---------
IF EXIST %OUTDIR%\%EXENAME% (
    echo Build successful!

    REM Remove unnecessary folders and files
    rmdir /s /q build 2>nul
    del %SCRIPT:.py=.spec% 2>nul

    REM OPTIONAL: delete the log if build succeeded
    del %LOG% 2>nul

    echo Output saved in "%OUTDIR%\%EXENAME%"
) ELSE (
    echo Build failed. See %LOG% for details.
)

pause
