`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: npc
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

module npc (
    input wire [1:0] BrTypeE,
    input wire BrE,
    input wire JrE,
    input wire [31:0] JrNPC,
    input wire [31:0] PCE,
    input wire [31:0] JumpNPCF,

    output wire [31:0] NPC
);

  // wrong branch prediction (back to PC4), jump Rs, else jump directly
  assign NPC = ((|BrTypeE) && ~BrE) ? PCE + 4 : (JrE) ? JrNPC : JumpNPCF;

endmodule
