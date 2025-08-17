<<<<<<< HEAD
=======
// Copyright 2025 Maktab-e-Digital Systems Lahore.
// Licensed under the Apache License, Version 2.0, see LICENSE file for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description:
//   SystemVerilog testbench for the top-level JPEG Encoder Core.
//   Reads input pixels from `script/pixel_data.txt`.
//   Captures the 32-bit JPEG bitstream output from DUT and writes to jpeg_output.hex.
//
// Author: Navaal Noshi
// Date:   17th August, 2025
>>>>>>> 7c836686dfa8ecad753f06cc324096d5c0be7dc6
`timescale 1ps / 1ps

module jpeg_top_TB;

    // --- Signals ---
    reg end_of_file_signal;
    reg [23:0] data_in;
    reg clk;
    reg rst;
    reg enable;

    logic [31:0] JPEG_bitstream;
    logic data_ready;
    logic [4:0] end_of_file_bitstream_count;
    logic eof_data_partial_ready;

    integer file_out;

    // --- Instantiate DUT ---
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
<<<<<<< HEAD
        file_out = $fopen("jpeg_output.hex", "w");  // write inside rtl folder
=======
        // Open hex file for writing
        file_out = $fopen("jpeg_output.hex", "w");
>>>>>>> 7c836686dfa8ecad753f06cc324096d5c0be7dc6
        if (file_out == 0) begin
            $display("❌ ERROR: Could not open jpeg_output.hex");
            $finish;
        end else $display("✅ Output file opened: jpeg_output.hex");

        clk = 0;
        rst = 1;
        enable = 0;
        end_of_file_signal = 0;
        data_in = 24'b0;

        #10000;
        rst = 0;
        enable = 1;

<<<<<<< HEAD
        // Include pixel data directly from rtl folder
        `include "pixel_data.txt"
=======
        // Include pixel data from script folder
        `include "./script/pixel_data.txt"
>>>>>>> 7c836686dfa8ecad753f06cc324096d5c0be7dc6

        #2000000;
        $fclose(file_out);
        $display("✅ JPEG bitstream written to jpeg_output.hex");
        $finish;
    end

    // --- Clock ---
    always begin
        clk = 0; #5000;
        clk = 1; #5000;
    end

    // --- Capture JPEG output ---
    always @(posedge clk) begin
        if (data_ready) begin
            if (file_out != 0) begin
                $fwrite(file_out, "%08h\n", JPEG_bitstream);
                $fflush(file_out);
            end
            $display("%08h", JPEG_bitstream);
        end
    end

endmodule
