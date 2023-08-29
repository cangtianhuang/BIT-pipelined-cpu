`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/08/27 15:16:51
// Design Name:
// Module Name: hazard_unit
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module hazard_unit (
    input wire [4:0] RsD,
    input wire [4:0] RtD,
    input wire AluSrcD,
    input wire MemToRegE,
    input wire [4:0] RegWriteAddrE,
    input wire JumpD,
    input wire JrE,
    input wire BrE,
    input wire [1:0] BrTypeD,
    input wire [1:0] BrTypeE,

    output wire stallIF,
    output wire stallID,
    output wire flushID,
    output wire flushEX
);

  wire load_use_stall = (MemToRegE && (RegWriteAddrE == RsD || (RegWriteAddrE == RtD && AluSrcD == `ALU_SRC_REG)));

  assign stallIF = load_use_stall;
  assign stallID = load_use_stall;
  assign flushEX = (JrE || ((|BrTypeE) && ~BrE));
  assign flushID = (JumpD || (|BrTypeD) || flushEX);

endmodule
