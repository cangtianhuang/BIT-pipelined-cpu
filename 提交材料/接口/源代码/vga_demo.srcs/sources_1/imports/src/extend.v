`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: extend
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

module extend (
    input wire [15:0] Imm16,
    input wire [ 1:0] ImmTypeD,

    output wire [31:0] ImmD
);

  assign ImmD = (ImmTypeD == `EXT_OP_SFT16) ? {Imm16, 16'b0} :  // lui: shift left 16
      (ImmTypeD == `EXT_OP_SIGNED) ? {{16{Imm16[15]}}, Imm16} : // I_Type, beq, bne: signed sign extend of imm16
      {16'b0, Imm16};  // lw, sw: unsigned sign extend of imm16

endmodule
