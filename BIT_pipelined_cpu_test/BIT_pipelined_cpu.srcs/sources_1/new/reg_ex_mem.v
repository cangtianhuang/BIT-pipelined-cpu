`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: reg_ex_mem
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

module reg_ex_mem (
    input wire        clk,
    input wire        rst,
    input wire [31:0] PCE,
    input wire [31:0] AluOutE,
    input wire [31:0] MemWriteDataE,
    input wire [ 4:0] RegWriteAddrE,

    input wire MemWriteE,
    input wire MemToRegE,
    input wire RegWriteE,
    input wire LoadNPCE,

    output reg [31:0] PCM,
    output reg [31:0] AluOutM,
    output reg [31:0] MemWriteDataM,
    output reg [ 4:0] RegWriteAddrM,

    output reg MemWriteM,
    output reg MemToRegM,
    output reg RegWriteM,
    output reg LoadNPCM
);

  always @(posedge clk) begin
    if (rst) begin
      PCM           <= 32'h0;
      AluOutM       <= 32'h0;
      MemWriteDataM <= 32'h0;
      RegWriteAddrM <= 5'b0;
      MemWriteM     <= 1'b0;
      MemToRegM     <= 1'b0;
      RegWriteM     <= 1'b0;
      LoadNPCM      <= 1'b0;
    end else begin
      PCM           <= PCE;
      AluOutM       <= AluOutE;
      MemWriteDataM <= MemWriteDataE;
      RegWriteAddrM <= RegWriteAddrE;
      MemWriteM     <= MemWriteE;
      MemToRegM     <= MemToRegE;
      RegWriteM     <= RegWriteE;
      LoadNPCM      <= LoadNPCE;
    end
  end

endmodule
