`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU Forwarding Unit
 *
 * Input:
 * Output:
 */

module forwarding_unit (
    input wire RegWriteM,
    input wire RegWriteW,
    input wire [4:0] RegWriteAddrM,
    input wire [4:0] RegWriteAddrW,
    input wire [4:0] RsE,
    input wire [4:0] RtE,
    input wire MemToRegM,

    output wire [1:0] ForwardRs,
    output wire [1:0] ForwardRt
);

  assign ForwardRs = ( RegWriteM && (|RegWriteAddrM) && RegWriteAddrM == RsE && ~MemToRegM) ? 2'b10 :
              ( RegWriteW && (|RegWriteAddrW ) && RegWriteAddrW == RsE && ~(RegWriteM && (|RegWriteAddrM)&&RegWriteAddrM==RsE)) ? 2'b01 : 2'b00;
  assign ForwardRt = ( RegWriteM && (|RegWriteAddrM) && RegWriteAddrM == RtE && ~MemToRegM) ? 2'b10 :
              ( RegWriteW && (|RegWriteAddrW ) && RegWriteAddrW == RtE && ~(RegWriteM && (|RegWriteAddrM)&&RegWriteAddrM==RtE)) ? 2'b01 : 2'b00;

endmodule
