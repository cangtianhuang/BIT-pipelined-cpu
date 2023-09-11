`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: reg_id_ex
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

module reg_id_ex (
    input wire        clk,
    input wire        rst,
    input wire [31:0] PCD,
    input wire [31:0] RegOut1D,
    input wire [31:0] RegOut2D,
    input wire [ 4:0] RsD,
    input wire [ 4:0] RtD,
    input wire [ 4:0] RdD,
    input wire [ 4:0] ShamtD,
    input wire [31:0] ImmD,

    input wire       RegWriteD,
    input wire       AluSrcD,
    input wire [3:0] AluOpD,
    input wire       MemWriteD,
    input wire       MemToRegD,
    input wire [1:0] RegDstD,
    input wire [1:0] BrTypeD,
    input wire       JrD,
    input wire       LoadNPCD,
    input wire       flushEX,

    output reg [31:0] PCE,
    output reg [31:0] RegOut1E,
    output reg [31:0] RegOut2E,
    output reg [ 4:0] RsE,
    output reg [ 4:0] RtE,
    output reg [ 4:0] RdE,
    output reg [ 4:0] ShamtE,
    output reg [31:0] ImmE,

    output reg       RegWriteE,
    output reg       AluSrcE,
    output reg [3:0] AluOpE,
    output reg       MemWriteE,
    output reg       MemToRegE,
    output reg [1:0] RegDstE,
    output reg [1:0] BrTypeE,
    output reg       JrE,
    output reg       LoadNPCE
);

  always @(posedge clk) begin

    if (rst || flushEX) begin
      PCE       <= 32'h0;
      RegOut1E  <= 32'h0;
      RegOut2E  <= 32'h0;
      RsE       <= 5'b0;
      RtE       <= 5'b0;
      RdE       <= 5'b0;
      ShamtE    <= 5'b0;
      ImmE      <= 16'h0;

      RegWriteE <= 1'b0;
      AluSrcE   <= 1'b0;
      AluOpE    <= 4'h0;
      MemWriteE <= 1'b0;
      MemToRegE <= 1'b0;
      RegDstE   <= 2'b0;
      BrTypeE   <= 2'b0;
      JrE       <= 1'b0;
      LoadNPCE  <= 1'b0;
    end else begin
      PCE       <= PCD;
      RegOut1E  <= RegOut1D;
      RegOut2E  <= RegOut2D;
      RsE       <= RsD;
      RtE       <= RtD;
      RdE       <= RdD;
      ShamtE    <= ShamtD;
      ImmE      <= ImmD;

      RegWriteE <= RegWriteD;
      AluSrcE   <= AluSrcD;
      AluOpE    <= AluOpD;
      MemWriteE <= MemWriteD;
      MemToRegE <= MemToRegD;
      RegDstE   <= RegDstD;
      BrTypeE   <= BrTypeD;
      JrE       <= JrD;
      LoadNPCE  <= LoadNPCD;
    end
  end

endmodule
