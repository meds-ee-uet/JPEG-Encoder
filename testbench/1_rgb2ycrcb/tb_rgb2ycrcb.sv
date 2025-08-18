// Copyright 2025 Maktab-e-Digital Systems Lahore.
// Licensed under the Apache License, Version 2.0, see LICENSE file for details.
// SPDX-License-Identifier: Apache-2.0
//
// Module Name: tb_rgb2ycrcb
// Description:
//    This testbench verifies the functionality of the `rgb2ycrcb` module, which
//    converts 24-bit RGB pixel data (8-bits per component) into 24-bit YCbCr
//    pixel data. It instantiates the `rgb2ycrcb` DUT and provides clock, reset,
//    enable, and input RGB data. The testbench applies a series of predefined
//    RGB test vectors (e.g., Red, Green, Blue, White, Black, Gray, Custom)
//    and monitors the `data_out` (YCbCr) and `enable_out` signals from the DUT.
//    It includes a task `apply_rgb` for convenient stimulus application and
//    tracks the number of valid outputs received. 
//
// Author:Navaal
// Date:20th July,2025.
//======================================================================
// Testbench for rgb2ycbcr
//======================================================================
//
// This testbench applies both fixed and random RGB inputs to the
// rgb2ycbcr module, and prints the converted YCbCr outputs.
//======================================================================

`timescale 1ns / 100ps

module tb_rgb2ycbcr;

  // DUT signals
  logic        clk;
  logic        rst;
  logic        enable;
  logic [23:0] data_in;
  logic [23:0] data_out;
  logic        enable_out;

  // Instantiate DUT
  rgb2ycbcr dut (
    .clk       (clk),
    .rst       (rst),
    .enable    (enable),
    .data_in   (data_in),
    .data_out  (data_out),
    .enable_out(enable_out)
  );

  // Clock generation (100 MHz → 10 ns period)
  always #5 clk = ~clk;

  // -------------------------------
  // Helper task: apply one RGB pixel
  // -------------------------------
  task apply_rgb(input [7:0] r, input [7:0] g, input [7:0] b);
    begin
      // Apply input
      data_in = {b, g, r}; // format = {B,G,R}
      enable  = 1;
      @(posedge clk);
      enable  = 0;

      // Wait for pipeline latency (3 cycles)
      repeat (3) @(posedge clk);

      // Print when output is valid
      if (enable_out) begin
        $display("Time=%0t | RGB=(%0d,%0d,%0d) --> YCbCr=(Y=%0d, Cb=%0d, Cr=%0d)",
                  $time, r, g, b,
                  data_out[7:0], data_out[15:8], data_out[23:16]);
      end
    end
  endtask

  // Random byte generator
  function [7:0] rand8();
    rand8 = $urandom_range(0, 255);
  endfunction

  // -------------------------------
  // Test sequence
  // -------------------------------
  initial begin
    // Initialize signals
    clk = 0;
    rst = 1;
    enable = 0;
    data_in = 0;

    // Reset for a few cycles
    repeat (4) @(posedge clk);
    rst = 0;

    // Fixed test patterns
    apply_rgb(8'd0,   8'd0,   8'd0);     // Black
    apply_rgb(8'd255, 8'd255, 8'd255);   // White
    apply_rgb(8'd255, 8'd0,   8'd0);     // Red
    apply_rgb(8'd0,   8'd255, 8'd0);     // Green
    apply_rgb(8'd0,   8'd0,   8'd255);   // Blue
    apply_rgb(8'd128, 8'd128, 8'd128);   // Mid-gray

    // Random test patterns
    repeat (10) begin
      apply_rgb(rand8(), rand8(), rand8());
    end

    $display("Simulation finished at time %0t", $time);
    $finish;
  end

endmodule
