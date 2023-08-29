`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU EX/MEM Register
 *
 * Input:
 * Output:
 */

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
      PCM           <= `INIT_32;
      AluOutM       <= `INIT_32;
      MemWriteDataM <= `INIT_32;
      RegWriteAddrM <= `INIT_5;
      MemWriteM     <= `MEM_WRITE_DIS;
      MemToRegM     <= `MemToReg_DIS;
      RegWriteM     <= `REG_WRITE_DIS;
      LoadNPCM      <= `LoadNPC_DIS;
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
