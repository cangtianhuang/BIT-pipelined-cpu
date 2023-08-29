`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU ALU
 *
 * Input:  .AluInput1 .AluInput2 .AluOp
 * Output: .alu_result
 */

module alu (
    input wire [31:0] AluInput1,
    input wire [31:0] AluInput2,
    input wire [ 4:0] Shamt,
    input wire [ 3:0] AluOp,

    output wire [31:0] AluOut,
    output wire        overflow
);

  reg [32:0] alu_temp_result;
  assign AluOut = alu_temp_result[31:0];

  // detect overflow
  assign overflow = (alu_temp_result[32] != alu_temp_result[31]) ? `OVERFLOW_TRUE : `OVERFLOW_FALSE;

  // displacement defined by Shamt or rs
  wire [4:0] displacement;
  assign displacement =
       (AluOp == `ALU_OP_SLL ||
        AluOp == `ALU_OP_SRL ||
        AluOp == `ALU_OP_SRA) ? Shamt : AluInput1[4:0];

  // compare rs and rt
  wire [31:0] diff;
  assign diff = (AluInput1 < AluInput2) ? 32'h00000001 : 32'h00000000;

  always @(*) begin
    case (AluOp)
      // normal arithmetic operations
      `ALU_OP_ADD: alu_temp_result <= {AluInput1[31], AluInput1} + {AluInput2[31], AluInput2};
      `ALU_OP_SUB: alu_temp_result <= {AluInput1[31], AluInput1} - {AluInput2[31], AluInput2};

      `ALU_OP_SLT: alu_temp_result <= diff;

      // bit operations
      `ALU_OP_AND: alu_temp_result <= {AluInput1[31], AluInput1} & {AluInput2[31], AluInput2};
      `ALU_OP_OR: alu_temp_result <= {AluInput1[31], AluInput1} | {AluInput2[31], AluInput2};
      `ALU_OP_NOR:
      alu_temp_result <= (({AluInput1[31], AluInput1} & ~{AluInput2[31], AluInput2}) |
                                (~{AluInput1[31], AluInput1} & {AluInput2[31], AluInput2}));
      `ALU_OP_XOR: alu_temp_result <= {AluInput1[31], AluInput1} ^ {AluInput2[31], AluInput2};

      // shift left logically
      `ALU_OP_SLL:  alu_temp_result <= {AluInput2[31], AluInput2} << displacement;
      `ALU_OP_SLLV: alu_temp_result <= {AluInput2[31], AluInput2} << displacement;

      // shift right logically
      `ALU_OP_SRL:  alu_temp_result <= {AluInput2[31], AluInput2} >> displacement;
      `ALU_OP_SRLV: alu_temp_result <= {AluInput2[31], AluInput2} >> displacement;

      // shift right arithmetically
      `ALU_OP_SRA:
      alu_temp_result <= ({{31{AluInput2[31]}}, 1'b0} << (~displacement)) | (AluInput2 >> displacement);
      `ALU_OP_SRAV:
      alu_temp_result <= ({{31{AluInput2[31]}}, 1'b0} << (~displacement)) | (AluInput2 >> displacement);

      `ALU_OP_DEFAULT: alu_temp_result <= {AluInput2[31], AluInput2};
    endcase
  end
endmodule
