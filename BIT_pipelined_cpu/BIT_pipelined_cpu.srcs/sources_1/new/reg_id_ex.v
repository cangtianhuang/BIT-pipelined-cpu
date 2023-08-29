`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU ID/EX Register
 *
 * Input:
 * Output:
 */

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
      PCE       <= `INIT_32;
      RegOut1E  <= `INIT_32;
      RegOut2E  <= `INIT_32;
      RsE       <= `INIT_5;
      RtE       <= `INIT_5;
      RdE       <= `INIT_5;
      ShamtE    <= `INIT_5;
      ImmE      <= `INIT_16;

      RegWriteE <= `REG_WRITE_DIS;
      AluSrcE   <= `ALU_SRC_REG;
      AluOpE    <= `ALU_OP_DEFAULT;
      MemWriteE <= `MEM_WRITE_DIS;
      MemToRegE <= `MemToReg_DIS;
      RegDstE   <= `REG_DST_DEFAULT;
      BrTypeE   <= 2'b00;
      JrE       <= 1'b0;
      LoadNPCE  <= `LoadNPC_DIS;
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
