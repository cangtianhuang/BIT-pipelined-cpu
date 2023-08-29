`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: reg_mem_wb
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

module reg_mem_wb (
    input wire        clk,
    input wire        rst,
    input wire [31:0] ResultM,
    input wire [31:0] ReadMemDataM,
    input wire [ 4:0] RegWriteAddrM,

    input wire MemToRegM,
    input wire RegWriteM,

    output reg [31:0] ResultW,
    output reg [31:0] ReadMemDataW,
    output reg [ 4:0] RegWriteAddrW,

    output reg MemToRegW,
    output reg RegWriteW
);

  always @(posedge clk) begin
    if (rst) begin
      ResultW       <= 32'h0;
      ReadMemDataW  <= 32'h0;
      RegWriteAddrW <= 5'b0;
      MemToRegW     <= 1'b0;
      RegWriteW     <= 1'b0;
    end else begin
      ResultW       <= ResultM;
      ReadMemDataW  <= ReadMemDataM;
      RegWriteAddrW <= RegWriteAddrM;
      MemToRegW     <= MemToRegM;
      RegWriteW     <= RegWriteM;
    end
  end

endmodule
