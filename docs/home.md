# Home
> © 2025 [Maktab-e-Digital Systems Lahore](https://github.com/meds-ee-uet)  
> Licensed under the Apache 2.0 License.


## Overview

The **JPEG Encoder** project converts **raw RGB images into JPEG compressed format** using a **hardware-based encoder implemented in SystemVerilog**.  
It is designed for real-time, low-power applications in embedded systems.

---
## Compression Example

*Before Compression vs After Compression*  
<p align="center">
  <img src="./docs/images_design_diagrams/compressed image.png" alt="Before and After Compression" width="700" height="400">
</p>
---

## Workflow Flowchart

<p align="center">
  <img src="./images_design_diagrams/flowchart.png" alt="Flowchart" width="700" height="500">
</p>

*Overall flow of JPEG Compression Steps*

---

## Why JPEG?

- Reduces file size by discarding perceptually insignificant data  
- Enables fast transmission and efficient memory use  
- Maintains high visual fidelity  
- Universally supported across hardware/software platforms  

---

## Repository Structure

The project is organized into **RTL design**, **Testbenches**, and **SDK utilities**.
| Folder        | Description |
|---------------|-------------|
| **rtl/**      | Core SystemVerilog modules for JPEG encoder: <br> • **Color Conversion**: `rgb2ycbcr` <br> • **DCT**: `y_dct`, `cb_dct`, `cr_dct` (+ `_constants.svh`) <br> • **Quantizers**: `y_quantizer`, `cr_quantizer`, `cb_quantizer` (+ `_constants.svh`) <br> • **Huffman**: `y_huff`, `cb_huff`, `cr_huff` <br> • **Bitstream Handling**: `pre_fifo`, `sync_fifo_ff`, `sync_fifo_32`, `ff_checker`, `fifo_out` <br> • **Combined**: `y_d_q_h`, `cb_d_q_h`, `cr_d_q_h` |
| **testbenches/** | Verification modules & input/output test data: <br> • `rgb2ycbcr_tb/` <br> • `dct_tb/` <br> • `quantization_tb/` <br> • `huffman_tb/` <br> • `jpeg_top_TB/` – full encoder verification |
| **sdk/**      | Scripts & tools for I/O and post-processing: <br> • `testimages/` – raw input images <br> • `output_images/` – compressed results <br> • `scripts/data_in.py` – converts images to 24-bit BGR pixel data (`pixel_data.txt`) <br> • `raw_jpeg_bitstream_to_image/jpeg.py` – merges headers + bitstreams into valid JPEG <br> • `Headers/` – predefined JPEG headers (`.bin`) <br> • `bitstream/` – sample bitstreams (`.hex`) <br> • `docs/` – diagrams & documentation |
## Licensing

Licensed under the **Apache License 2.0**
Copyright © 2025
**[Maktab-e-Digital Systems Lahore](https://github.com/meds-ee-uet)**

---