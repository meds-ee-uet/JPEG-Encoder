# Copyright 2025 Maktab-e-Digital Systems Lahore.
# Licensed under the Apache License, Version 2.0, see LICENSE file for details.
# SPDX-License-Identifier: Apache-2.0
#
# Description:
# This Python script converts an RGB image (specifically resized to 96×96 pixels) into a SystemVerilog-compatible stimulus file
# by extracting the red, green, and blue values of each pixel and formatting them as 24-bit binary values, where blue occupies bits [23:16], green [15:8], 
# and red [7:0]. Each line in the output file assigns a pixel to the data_in signal in the format data_in <= 24'b...; followed by a delay (#10000;),
# making it suitable for use in a Verilog or SystemVerilog testbench for simulating an image-processing module like a JPEG encoder.
#
# Author:Navaal Noshi
# Date:30th July,2025

from PIL import Image
import numpy as np

# --- Configuration ---
image_path = "desert.jpg"   # input image
output_file = "pixel_data.txt"
block_size = 8

# --- Read the image (like MATLAB imread) ---
img = np.array(Image.open(image_path))   # RGB

# --- Convert to BGR (same as MATLAB img(:,:, [3 2 1])) ---
imgBGR = img[:, :, [2, 1, 0]]

# Image size
h, w, _ = imgBGR.shape
total_pixels = h * w
pixel_count = 0

with open(output_file, "w") as f:
    # Go through blocks
    for by in range(0, h, block_size):
        for bx in range(0, w, block_size):
            # Extract one 8x8 block (same as MATLAB slice)
            block = imgBGR[by:by+block_size, bx:bx+block_size, :]

            # If this is the very last block → assert EOF once
            if pixel_count == total_pixels - 64:
                f.write("end_of_file_signal  <= 1'b1;\n")

            # Loop through 8x8 block pixels, row by row (left→right, top→down)
            for row in range(block_size):
                for col in range(block_size):
                    B, G, R = block[row, col]   # direct pixel read
                    pixel_count += 1

                    # Convert each channel to 8-bit binary
                    Rbin = format(R, "08b")
                    Gbin = format(G, "08b")
                    Bbin = format(B, "08b")

                    # BGR order
                    binStr = f"{Bbin}{Gbin}{Rbin}"

                    # Write pixel to file
                    f.write(f"\tdata_in <= 24'b{binStr};\n#10000;\n")

            # Only add block-separator if NOT the last block
            if pixel_count < total_pixels:
                f.write("#130000;\n")
                f.write("enable <= 1'b0;\n")
                f.write("#10000;\n")
                f.write("enable <= 1'b1;\n")

    # At the extreme end, only these three lines
    f.write("#130000;\n")
    f.write("enable <= 1'b0;\n")

print("✅ Pixel data written to pixel_data.txt (8x8 blocks, row-major, EOF only before last block)")
