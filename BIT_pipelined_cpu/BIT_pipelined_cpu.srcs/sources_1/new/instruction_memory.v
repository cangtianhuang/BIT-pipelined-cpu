`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU Instruction Memory
 *
 * Input:  .instruction_addr
 * Output: .instruction
 */

module instruction_memory (
    input wire [11:2] instr_addr,  // PC fetch instruction address

    output wire [31:0] instr  // IM fetch instruction from register
);

  reg [31:0] memory[1023:0];
  assign instr = memory[instr_addr];
endmodule
