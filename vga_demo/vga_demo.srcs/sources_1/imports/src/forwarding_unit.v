`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: forwarding_unit
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

// MEM: write to register, target register not zero, same target register, not read from memory (lw)
// WB: ..., no reads from memory in last cycle (lw, must stall)
  assign ForwardRs = (RegWriteM && (|RegWriteAddrM) && RegWriteAddrM == RsE && ~MemToRegM) ? `FORWARD_FROM_MEM :
    (RegWriteW && (|RegWriteAddrW) && RegWriteAddrW == RsE && ~(RegWriteM && (|RegWriteAddrM) && RegWriteAddrM == RsE)) ? `FORWARD_FROM_WB :
    `FORWARD_DEFAULT;

  assign ForwardRt = (RegWriteM && (|RegWriteAddrM) && RegWriteAddrM == RtE && ~MemToRegM) ? `FORWARD_FROM_MEM :
    (RegWriteW && (|RegWriteAddrW) && RegWriteAddrW == RtE && ~(RegWriteM && (|RegWriteAddrM) && RegWriteAddrM == RtE)) ? `FORWARD_FROM_WB :
    `FORWARD_DEFAULT;

endmodule
