`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: data_memory
// Project Name: BIT_pipelined_cpu
// Target Devices: xc7a35tcsg324-1
// Tool Versions: Vivado 2019.2
// Description:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module data_memory (
    input wire clk,
    input wire rst,
    input wire MemWrite,  // enable memory write
    input wire MemRead,  // enable memory read
    input wire [11:2] MemAddr,       // memory target address ( byte-oriented >> 2 -> word-oriented(4bytes) )
    input wire [31:0] WriteMemData,  // write data to data memory
    output wire [31:0] ReadMemData,  // read data from data memory

    input  wire [11:2] WordAddr,   // read or write data about outsides
    input  wire        WordWrite,  // signal: read: 0, write: 1
    input  wire [31:0] WriteWord,  // write data from outsides
    output wire [31:0] ReadWord    // read data to outsides
);

  // Data Memory Storage (word-oriented)
  reg [31:0] memory[31:0];
  integer i;

  //initial for (i = 0; i < 32; i = i + 1) memory[i] = 0;
  initial $readmemh("C:/Users/86159/Downloads/data.mem", memory);

  wire [11:2] addr = (MemWrite) ? MemAddr : (WordWrite) ? WordAddr : 0;
  wire [31:0] data = (MemWrite) ? WriteMemData : (WordWrite) ? WriteWord : 0;

  assign ReadWord = WordWrite ? 32'h0 : memory[WordAddr];
  assign ReadMemData = MemRead ? memory[MemAddr] : 32'h0;

  always @(negedge clk) begin
    if (WordWrite || MemWrite) memory[addr] = data;
  end

endmodule
