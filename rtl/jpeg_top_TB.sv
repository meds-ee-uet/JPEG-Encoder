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
`timescale 1ps / 1ps

module jpeg_top_TB;

    // --- Signal Declarations ---
    bit end_of_file_signal;
    logic [23:0] data_in;
    logic clk;
    logic rst;
    bit enable;

    logic [31:0] JPEG_bitstream;
    logic data_ready;
    logic [4:0] end_of_file_bitstream_count;
    logic eof_data_partial_ready;

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
        file_out = $fopen("jpeg_output.hex", "w");
        if (file_out == 0) begin
            $display("❌ ERROR: Could not open file.");
            $finish;
        end else begin
            $display("✅ File opened successfully");
        end

        // Initialize signals
        clk = 0;
        rst = 1;
        enable = 0;
        end_of_file_signal = 0;
        data_in = 24'b0;

        // Reset UUT
        #10000;
        rst = 0;
        enable = 1;

        // Include pixel data from script folder
        `include "./script/pixel_data.txt"

        // Wait for last data to finish
        #2000000;

        // Close file and finish
        $fclose(file_out);
        $display("✅ JPEG bitstream written to file");
        $finish;
    end

    // --- Clock Generation ---
    always begin
        clk = 0; #5000;
        clk = 1; #5000;
    end

    // --- Capture JPEG Output ---
    always_ff @(posedge clk) begin
        if (data_ready) begin
            if (file_out != 0) begin
                $fwrite(file_out, "%08h\n", JPEG_bitstream);
            end
            $display("%08h", JPEG_bitstream);
        end
    end

endmodule
