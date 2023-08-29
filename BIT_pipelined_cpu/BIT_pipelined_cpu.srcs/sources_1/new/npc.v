`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU Next Program Counter
 *
 * Input:  .clk .pc .imm16 .imm26 .en_npc_op
 * Output: .npc
 */

module npc (
    input wire [31:0] PCF,

    input wire JumpD,
    input wire JrE,
    input wire [1:0] BrTypeD,
    input wire [1:0] BrTypeE,
    input wire BrE,
    input wire [31:0] JumpNPC,
    input wire [31:0] JrNPC,
    input wire [31:0] BrNPCD,
    input wire [31:0] PCE,

    output wire [31:0] NPC  // next program counter
);

  assign NPC = (JumpD) ? JumpNPC : (|BrTypeD) ? BrNPCD : ( (|BrTypeE) && ~BrE ) ? PCE + 4 : (JrE) ? JrNPC : PCF + 4;
endmodule
