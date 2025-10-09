<p align="center">
  <img src="docs/images_design_diagrams/meds.jpg" alt="MEDS UET Logo" width="80" height="80">
</p>

<h1 align="center">JPEG-Based Lossy Image Compression System</h1>

<p align="center">
  <b>A hardware-implemented JPEG encoder for efficient lossy image compression using SystemVerilog.</b>
</p>


## Top-Level Block Diagram

<p align="center">
  <img src="docs/images_design_diagrams/JPEG-Top-level-module.png" 
   alt="JPEG Encoder Architecture" width="600">
</p>

---

## Key Features

- Fully synthesizable **SystemVerilog implementation** of JPEG encoder modules 
- Includes **DCT**, **Quantization**, and **Huffman Encoding** blocks 
- Modular architecture for **Y, Cb, and Cr** component processing 
- Verified using **Cocotb testbenches** with Python golden models 
- Supports **pipeline optimization** and **byte-stuffing handling**

---

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/YourUsername/JPEG-Encoder.git
cd JPEG-Encoder
```

##  Run JPEG Compression

First do this:
```bash
cd sdk
```
To compress an image, simply run:

```bash
run.bat
```

## Quick Links

| Category | Description | Location |
|----------|-------------|----------|
|  **Documentation** | ReadTheDocs Project Page | [ReadTheDocs](https://jpeg-encoder5.readthedocs.io/en/latest/) |
|  **Simulations** | All testbenches | `tests/` directory |
| **Modules** | Each core block (DCT, Quantizer, Huffman, FIFO) | `rtl/` directory |
| **License** | Project's license file | `LICENSE` |

---

## Full Documentation

For detailed module descriptions, timing diagrams, and verification results, visit:

**[Full Documentation on ReadTheDocs](https://jpeg-encoder5.readthedocs.io/en/latest/)**

---

<p align="center">
  Developed at the <b>(MEDS)</b>, UET Lahore.
</p>
