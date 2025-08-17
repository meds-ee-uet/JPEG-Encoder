// Copyright 2025 Maktab-e-Digital Systems Lahore.
// Licensed under the Apache License, Version 2.0, see LICENSE file for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description:
//    This module implements a synchronous First-In, First-Out (FIFO) buffer.
//    It is configured with a 32-bit data width and has a storage capacity of 16 entries.
//    The FIFO provides `read_data` output for the dequeued item, a `fifo_empty` signal
//    to indicate its empty status, and an `rdata_valid` signal to indicate when valid
//    data is available on the `read_data` output. This FIFO is typically used for
//    data staging in various pipelined architectures, such as JPEG processing chains.
//
// Author:Navaal Noshi
// Date:16th July,2025.


`timescale 1ns / 100ps

module sync_fifo_32 (clk, rst, read_req, write_data, write_enable, 
read_data, fifo_empty, rdata_valid);
input	clk;
input	rst;
input	read_req;
input [31:0] write_data;
input write_enable;
output [31:0] read_data;  
output  fifo_empty; 
output	rdata_valid;
   
reg [4:0] read_ptr;
reg [4:0] write_ptr;
reg [31:0] mem [0:15];
reg [31:0] read_data;
reg rdata_valid;
logic [3:0] write_addr = write_ptr[3:0];
logic [3:0] read_addr = read_ptr[3:0];	
logic read_enable = read_req && (~fifo_empty);
assign fifo_empty = (read_ptr == write_ptr);


always_ff @(posedge clk)
  begin
   if (rst)
      write_ptr <= {(5){1'b0}};
   else if (write_enable)
      write_ptr <= write_ptr + {{4{1'b0}},1'b1};
  end

always_ff @(posedge clk)
begin
   if (rst)
      rdata_valid <= 1'b0;
   else if (read_enable)
      rdata_valid <= 1'b1;
   else
   	  rdata_valid <= 1'b0;  
end
  
always_ff @(posedge clk)
 begin
   if (rst)
      read_ptr <= {(5){1'b0}};
   else if (read_enable)
      read_ptr <= read_ptr + {{4{1'b0}},1'b1};
end

// Mem write
always_ff @(posedge clk)
  begin
   if (write_enable)
     mem[write_addr] <= write_data;
  end
// Mem Read
always_ff @(posedge clk)
  begin
   if (read_enable)
      read_data <= mem[read_addr];
  end
  
endmodule
