
# Converts JPEG bitstream from simulation to an actual JPEG image using a header file
# Saves compressed version and optionally upscales back to original size

from PIL import Image, ImageFile
import io

ImageFile.LOAD_TRUNCATED_IMAGES = True  # allow loading incomplete JPEGs

# -------------------------
# File paths (change if needed)
# -------------------------
header_file = 'header.bin'          # The JPEG header
hex_file = 'jpeg_output.hex'        # The output from your Verilog TB
compressed_jpg = 'output_image.jpg' # Final compressed JPEG (96x96)
upscaled_jpg = 'output_upscaled.jpg' # Optional upscaled version

# -------------------------
# Step 1: Read the header
# -------------------------
with open(header_file, 'rb') as f:
    header = f.read()

# -------------------------
# Step 2: Read the hex bitstream and convert to bytes
# -------------------------
bitstream_bytes = bytearray()

with open(hex_file, 'r') as f:
    for line in f:
        line = line.strip()
        if line == '':
            continue
        val = int(line, 16)
        bytes_chunk = val.to_bytes(4, byteorder='big')  # 32-bit → 4 bytes
        bitstream_bytes.extend(bytes_chunk)

# -------------------------
# Step 3: Combine header + bitstream (JPEG in memory)
# -------------------------
jpeg_data = header + bitstream_bytes

# -------------------------
# Step 4: Open from memory and save compressed version
# -------------------------
try:
    img = Image.open(io.BytesIO(jpeg_data))

    # Save compressed 96x96
    img.save(
        compressed_jpg,
        "JPEG",
        quality=40,       # adjust 30–60 for smaller size
        optimize=True,
        progressive=True
    )
    print(f"📉 Compressed JPEG saved: {compressed_jpg}")

    # -------------------------
    # Step 5: Upscale back (optional)
    # -------------------------
    original_size = (640, 480)  # 👈 put your real original size here
    img_up = img.resize(original_size, Image.LANCZOS)
    img_up.save(
        upscaled_jpg,
        "JPEG",
        quality=40,
        optimize=True,
        progressive=True
    )
    print(f"📈 Upscaled JPEG saved: {upscaled_jpg} ({original_size[0]}x{original_size[1]})")

except Exception as e:
    print("⚠️ Could not recompress JPEG:", e)
