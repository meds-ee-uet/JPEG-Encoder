# image_to_hex_and_blocks.py
# Convert any image into 96x96 hex dump + Verilog-style pixel data file

from PIL import Image
import numpy as np

# --- Configuration ---
input_image = "test.jpg"        # input image (any size)
hex_file = "input_96.hex"      # plain hex RGB values
pixel_file = "pixel_data.txt"  # Verilog-style data stream
width, height = 96, 96         # resize target
block_size = 8

# -------------------------
# Step 1: Resize to 96x96 and save hex dump
# -------------------------
def image_to_hex(img_path, hex_out, width=96, height=96):
    img = Image.open(img_path).convert("RGB")
    img_resized = img.resize((width, height), Image.LANCZOS)

    with open(hex_out, "w") as f:
        for y in range(height):
            for x in range(width):
                r, g, b = img_resized.getpixel((x, y))
                f.write(f"{r:02X}\n{g:02X}\n{b:02X}\n")

    print(f"📥 Image {img_path} resized to {width}x{height} and written as {hex_out}")
    return np.array(img_resized)  # return resized array for block writer

# -------------------------
# Step 2: Generate Verilog-style block stream
# -------------------------
def image_to_blocks(img_array, block_out, block_size=8):
    # Convert to BGR (like MATLAB img(:,:, [3 2 1]))
    imgBGR = img_array[:, :, [2, 1, 0]]
    h, w, _ = imgBGR.shape
    total_pixels = h * w
    pixel_count = 0

    with open(block_out, "w") as f:
        for by in range(0, h, block_size):
            for bx in range(0, w, block_size):
                block = imgBGR[by:by+block_size, bx:bx+block_size, :]

                # If this is the very last block → assert EOF
                if pixel_count == total_pixels - 64:
                    f.write("end_of_file_signal  <= 1'b1;\n")

                for row in range(block_size):
                    for col in range(block_size):
                        B, G, R = block[row, col]
                        pixel_count += 1

                        Rbin = format(R, "08b")
                        Gbin = format(G, "08b")
                        Bbin = format(B, "08b")
                        binStr = f"{Bbin}{Gbin}{Rbin}"

                        f.write(f"\tdata_in <= 24'b{binStr};\n#10000;\n")

                if pixel_count < total_pixels:
                    f.write("#130000;\n")
                    f.write("enable <= 1'b0;\n")
                    f.write("#10000;\n")
                    f.write("enable <= 1'b1;\n")

        f.write("#130000;\n")
        f.write("enable <= 1'b0;\n")

    print(f"✅ Pixel data written to {block_out} (8x8 blocks, row-major, EOF only before last block)")

# -------------------------
# Run the pipeline
# -------------------------
if __name__ == "__main__":
    resized_array = image_to_hex(input_image, hex_file, width, height)
    image_to_blocks(resized_array, pixel_file, block_size)
