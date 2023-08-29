`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU MEM/WB Register
 *
 * Input:
 * Output:
 */

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
      ResultW       <= `INIT_32;
      ReadMemDataW  <= `INIT_32;
      RegWriteAddrW <= `INIT_5;
      MemToRegW     <= `MemToReg_DIS;
      RegWriteW     <= `REG_WRITE_DIS;
    end else begin
      ResultW       <= ResultM;
      ReadMemDataW  <= ReadMemDataM;
      RegWriteAddrW <= RegWriteAddrM;
      MemToRegW     <= MemToRegM;
      RegWriteW     <= RegWriteM;
    end
  end
endmodule
