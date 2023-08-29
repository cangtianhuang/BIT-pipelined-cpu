`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU Data Memory
 *
 * Input:  .clk .en_mem_write .mem_addr .write_mem_data
 * Output: .read_mem_data
 */

module data_memory (
    input  wire        clk,
    input  wire        rst,
    input  wire        MemWrite,      // enable memory write
    input  wire        MemRead,       // enable memory read
    input  wire [11:2] MemAddr,       // memory target address
    input  wire [31:0] WriteMemData,  // write data to data memory
    output wire [31:0] ReadMemData    // read data from data memory

);

  // Data Memory Storage
  reg [31:0] memory[1023:0];
  assign ReadMemData = MemRead ? memory[MemAddr] : 32'b0;
  integer i;

  always @(posedge clk) begin
    if (rst) begin
      for (i = 0; i < 32; i = i + 1) begin
        memory[i] <= 32'b0;
      end
    end else if (MemWrite) begin
      memory[MemAddr] <= WriteMemData;
    end
  end
endmodule
