`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/07 16:51:40
// Design Name:
// Module Name: direct_jump
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


module direct_jump (
    input wire [5:0] OpF,
    input wire [5:0] FunctF,
    input wire [25:0] AddrF,
    input wire [15:0] Imm16F,
    input wire [31:0] PCF,
    output wire [31:0] JumpNPCF,
    output wire JrF
);

  wire inst_beq_bne, inst_j_jal, inst_jr_jalr;

  assign inst_beq_bne = (OpF == `INST_BEQ || OpF == `INST_BNE) ? 1 : 0;
  assign inst_j_jal = (OpF == `INST_J || OpF == `INST_JAL) ? 1 : 0;
  assign inst_jr_jalr = (OpF == `INST_R_TYPE && (FunctF==`FUNC_JR||FunctF==`FUNC_JALR)) ? 1:0;

  assign JumpNPCF = (inst_beq_bne) ? PCF + 32'h4 + (Imm16F << 2) :
    (inst_j_jal) ? {PCF[31:28], AddrF, 2'b00} : PCF + 4;

  assign JrF = inst_jr_jalr;

endmodule
