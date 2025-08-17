@echo off
cd %~dp0

echo Step 1: Preprocess the test image
python scripts\for_all.py

echo Step 2: Compile RTL and run testbench
mingw32-make -C RTL

echo Step 3: Convert output hex to JPEG
python scripts\for_all_hex_to_jpg.py output.hex output.jpg

echo Done! Output saved as output.jpg
pause
