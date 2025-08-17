// Copyright 2025 Maktab-e-Digital Systems Lahore.
// Licensed under the Apache License, Version 2.0, see LICENSE file for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description:
//   This is the SystemVerilog testbench for the top-level JPEG Encoder Core.
//   It verifies functionality by:
//   1. Providing input pixel data from an external file (`pixel_data.txt`).
//   2. Driving clock, reset, enable, and end-of-file signals.
//   3. Capturing the 32-bit JPEG bitstream output from the DUT (`jpeg_top`).
//   4. Writing the bitstream to `jpeg_output.hex` for further verification.
//
//   The testbench uses relative file paths to ensure portability. This allows
//   the design to be cloned and run on any system without modifying paths.
//
// Author: Navaal Noshi
// Date:   17th August, 2025
`timescale 1ps / 1ps

// Testbench for JPEG top module
module jpeg_top_TB;

    // --- Signal Declarations ---
    reg end_of_file_signal;
    reg [23:0] data_in;
    reg clk;
    reg rst;
    reg enable;
    logic  [31:0] JPEG_bitstream;
    logic  data_ready;
    logic  [4:0] end_of_file_bitstream_count;
    logic  eof_data_partial_ready;

    // File handle for writing JPEG output
    integer file_out;

    // --- Instantiate Unit Under Test ---
    jpeg_top UUT (
        .end_of_file_signal(end_of_file_signal),
        .data_in(data_in),
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .JPEG_bitstream(JPEG_bitstream),
        .data_ready(data_ready),
        .end_of_file_bitstream_count(end_of_file_bitstream_count),
        .eof_data_partial_ready(eof_data_partial_ready)
    );

    // --- Initial Stimulus ---
    initial begin : STIMUL
        // Open hex file for writing
        file_out = $fopen("C:/Users/HH Traders/JPEG-Encoder/rtl/jpeg_output.hex", "w");
        if (file_out == 0) begin
            $display("ERROR: Could not open file.");
            $finish;
        end else begin
            $display("File opened successfully");
        end

        #0
	    rst = 1'b1;
	    enable = 1'b0;
	    end_of_file_signal = 1'b0;
        #10000; 
	    rst = 1'b0;
	    enable = 1'b1;
	

        // Include pixel data
        `include "C:/Users/HH Traders/JPEG-Encoder/rtl/pixel_data.txt"

        // Wait for last data to finish
        #2000000;

        // Close file and finish
        $fclose(file_out);
        $display("JPEG bitstream written to file");
        $finish;
    end

    // --- Clock Generation ---
    always begin
       clk = 1'b0; #5000;
        clk =1'b1;; #5000;
    end

    // --- Capture JPEG Output ---
    always @(posedge clk) begin
        if (data_ready==1'b1) begin
            if (file_out != 0) begin
                $fwrite(file_out, "%08h\n", JPEG_bitstream);
            end
            $display("%08h", JPEG_bitstream);
        end
    end

endmodule
