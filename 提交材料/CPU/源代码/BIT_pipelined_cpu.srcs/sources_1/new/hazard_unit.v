`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: hazard_unit
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

module hazard_unit (
    input wire [4:0] RsD,
    input wire [4:0] RtD,
    input wire AluSrcD,
    input wire MemToRegE,
    input wire [4:0] RegWriteAddrE,
    input wire JrD,
    input wire JrE,
    input wire BrE,
    input wire [1:0] BrTypeE,

    output wire stallIF,
    output wire stallID,
    output wire flushID,
    output wire flushEX
);

  // load-use data adventure: Memory will write to a register that is the same as the source register (Rs or Rt)
  wire load_use_stall = (MemToRegE && (RegWriteAddrE == RsD || (RegWriteAddrE == RtD && AluSrcD == `ALU_SRC_REG)));

  assign stallIF = load_use_stall;
  assign stallID = load_use_stall;

  // jump, predict branch: flush one cycle (can be optimized: get Addr in IF stage)
  // jr, wrong predict branch: flush two cycles
  wire flush_two_cycle = ((|BrTypeE) && ~BrE);

  // load_use_stall need to flush EX
  assign flushEX = (load_use_stall || flush_two_cycle);
  assign flushID = (JrD || JrE || flush_two_cycle);

endmodule
