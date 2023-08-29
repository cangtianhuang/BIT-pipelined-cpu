`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU Extend
 *
 * Input:  .imm16 .cu_ext_op
 * Output: .extended_imm
 */

module extend (
    input wire [15:0] Imm16,
    input wire [ 1:0] ImmTypeD,

    output wire [31:0] ImmD
);

  assign ImmD = (ImmTypeD == `EXT_OP_SFT16) ? {Imm16, 16'b0} :  // LUI: shift left 16
      (ImmTypeD == `EXT_OP_SIGNED) ? {{16{Imm16[15]}}, Imm16} : // ADDIU: signed sign extend of imm16
      {16'b0, Imm16};  // LW, SW: unsigned sign extend of imm16
endmodule
