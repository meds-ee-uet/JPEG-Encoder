# Developer-Guide

© 2025 **Maktab-e-Digital Systems Lahore**  
Licensed under the [Apache 2.0 License](https://www.google.com/search?q=LICENSE)

---
## Run Simulation

Run the provided batch file:

- **Windows:**  
  Double-click `run.bat`

- **Linux/Mac:**  
  Run commands manually:

  ```bash
  python data_in.py
  vlog ./src/*.sv ./testbench/*.sv
  vsim -c -do "run -all; quit" tb_top
  python script/raw_jpeg_bitstream_to_image/jpeg.py
  ```

  Or create your own `run_sim.sh` shell script to automate.
## Testbenches
## Overall Testing:

##  `jpeg_top_TB`

Testbench verifies the jpeg_top module by feeding it pixel data from an external file `data_in` and capturing the compressed JPEG bitstream. At the start, it opens output file `jpeg_output.hex` where the results will be saved. The DUT is reset and enabled, after which the pixel values are applied as 24-bit RGB inputs. During simulation, whenever the data_ready signal is asserted, the 32-bit JPEG bitstream word is written in hexadecimal format to both output files and also displayed on the console. Once all input pixels are processed and the end-of-file condition is reached, the files are closed and the simulation ends, confirming that the JPEG bitstream has been successfully generated.

## Module-Wise Testing:
##  1. `tb_rgb2ycrcb`

### 1. Purpose of Test Cases
The testbench is designed to check the accuracy of color space conversion under common edge cases and validate robustness with random RGB inputs. It ensures proper pipeline behavior, rounding, and output timing of the rgb2ycrcb module.

 ### 2. Expected Output:
Each input is applied with a 1-cycle enable signal and a 3-cycle wait to accommodate pipeline latency. The testbench checks for a valid `enable_out` and prints the YCbCr result in a readable format. 

 <div align="center">
 <img src="https://github.com/rmknae/JPEG-Encoder/raw/main/docs/images_testbench_EO_CO/rgb2ycrcb_EO_CO.png" alt="RGB to YCbCr EO/CO Testbench Output" width="500" height="380">
 </div>

---

## 2. `*_dct:`
### 1. Purpose of Test Cases
This testbench verifies the `*_dct module`, which performs an 8×8 Discrete Cosine Transform (DCT) on image blocks as part of JPEG encoding. It serially feeds 8-bit input pixels and observes 64 signed 11-bit DCT output coefficients. The test also tracks `output_enable` to confirm pipeline latency.

 ### 2. Expected Output:
Once processing is complete, `output_enable` goes high.
The testbench prints:
- The full 8×8 DCT coefficient matrix using `$write` formatting.
- A status line summarizing timing and DC verification,
  
 ### `*_dct`:
  
<div align="center">
  <img src="https://github.com/rmknae/JPEG-Encoder/raw/main/docs/images_testbench_EO_CO/dct_EO_CO.png" alt="DCT EO/CO Testbench Output" width="500" height="320">
</div>

---

## 3. `tb_*_quantizer`
### 1. Purpose
The test cases are designed to confirm that the quantization logic correctly applies scaling and rounding to signed DCT coefficients. The expected outputs are computed using the same reciprocal-based method used in hardware: multiplying by (4096 / Q[i][j]), right-shifting by 12, and rounding toward zero. The goal is to validate accuracy, rounding behavior, and pipeline timing across various coefficient patterns.

### 2. Expected Outputs
After applying inputs and enabling the module for one clock cycle, the testbench waits for the `out_enable signal` to assert (indicating pipeline completion). It then prints the input matrix, expected quantized values, and actual hardware outputs side-by-side for visual comparison

 ### `*_quantizer:` 
  
  <div align="center">
  <img src="https://github.com/rmknae/JPEG-Encoder/raw/main/docs/images_testbench_EO_CO/quantizer_EO_CO.png" alt="Quantizer EO/CO Testbench Output" width="500" height="380">
  </div>
  
  
---

## 4. `tb_*_huff`:
### 1. Purpose
The testbench validates the functionality of the `*_huff module`, which performs Huffman encoding on an 8×8 block of quantized DCT coefficients for the components in JPEG compression. It ensures correct encoding of sparse DCT blocks, including proper handling of DC and AC coefficients, `output bitstream` generation, and `end-of-block signaling`.
  
### 2. Expected Outputs
For each test case, the monitor displays:The evolving state of `data_ready`, `output_reg_count`, `end_of_block_output`, and `JPEG_bitstream`.The encoded output should reflect the DC value followed by Huffman-encoded non-zero AC coefficients, terminated with an end-of-block symbol.

 ### `*_huff`:
  
  <div align="center">
 <img src="https://github.com/rmknae/JPEG-Encoder/blob/main/docs/images_testbench_EO_CO/y_huff_EO_CO.png" alt="Y Huffman EO/CO Testbench Output" width="600" height="380">
  </div>

---
Licensed under the **Apache License 2.0**
Copyright © 2025
**[Maktab-e-Digital Systems Lahore](https://github.com/meds-ee-uet)**

---
