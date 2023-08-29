`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU Control Unit
 */

module control_unit (
    input wire       rst,
    input wire [5:0] OpD,     // Instruction Op
    input wire [4:0] ShamtD,  // Shift operation operand
    input wire [5:0] FunctD,  // R-Type instruction function

    output wire       RegWriteD,
    output wire [1:0] ImmTypeD,
    output wire       AluSrcD,
    output wire [3:0] AluOpD,
    output wire       MemWriteD,
    output wire       MemToRegD,
    output wire [1:0] RegDstD,
    output wire [1:0] BrTypeD,
    output wire       JumpD,
    output wire       JrD,
    output wire       LoadNPCD
);

  // Init instruction signals
  wire type_r, inst_add, inst_addu, inst_sub, inst_subu, inst_slt;
  wire inst_sltu, inst_and, inst_or, inst_nor, inst_xor, inst_sll;
  wire inst_srl, inst_sra, inst_sllv, inst_srlv, inst_srav, inst_jr;
  wire inst_jalr, inst_addi, inst_addiu, inst_sltiu;
  wire inst_andi, inst_ori, inst_xori, inst_lui, inst_lw, inst_sw;
  wire inst_beq, inst_bne, inst_j, inst_jal;

  /* --- Decode instructions --- */

  // Whether instruction is R-Type
  assign type_r = (OpD == `INST_R_TYPE) ? 1 : 0;
  // R-Type instructions
  assign inst_add = (type_r && FunctD == `FUNC_ADD) ? 1 : 0;
  assign inst_addu = (type_r && FunctD == `FUNC_ADDU) ? 1 : 0;
  assign inst_sub = (type_r && FunctD == `FUNC_SUB) ? 1 : 0;
  assign inst_subu = (type_r && FunctD == `FUNC_SUBU) ? 1 : 0;
  assign inst_slt = (type_r && FunctD == `FUNC_SLT) ? 1 : 0;
  assign inst_sltu = (type_r && FunctD == `FUNC_SLTU) ? 1 : 0;
  assign inst_and = (type_r && FunctD == `FUNC_AND) ? 1 : 0;
  assign inst_or = (type_r && FunctD == `FUNC_OR) ? 1 : 0;
  assign inst_nor = (type_r && FunctD == `FUNC_NOR) ? 1 : 0;
  assign inst_xor = (type_r && FunctD == `FUNC_XOR) ? 1 : 0;
  assign inst_sll = (type_r && FunctD == `FUNC_SLL) ? 1 : 0;
  assign inst_srl = (type_r && FunctD == `FUNC_SRL) ? 1 : 0;
  assign inst_sra = (type_r && FunctD == `FUNC_SRA) ? 1 : 0;
  assign inst_sllv = (type_r && FunctD == `FUNC_SLLV) ? 1 : 0;
  assign inst_srlv = (type_r && FunctD == `FUNC_SRLV) ? 1 : 0;
  assign inst_srav = (type_r && FunctD == `FUNC_SRAV) ? 1 : 0;
  assign inst_jr = (type_r && FunctD == `FUNC_JR) ? 1 : 0;
  assign inst_jalr = (type_r && FunctD == `FUNC_JALR) ? 1 : 0;

  // I-Type Instructions
  assign inst_addi = (OpD == `INST_ADDI) ? 1 : 0;
  assign inst_addiu = (OpD == `INST_ADDIU) ? 1 : 0;
  assign inst_sltiu = (OpD == `INST_SLTIU) ? 1 : 0;
  assign inst_andi = (OpD == `INST_ANDI) ? 1 : 0;
  assign inst_ori = (OpD == `INST_ORI) ? 1 : 0;
  assign inst_xori = (OpD == `INST_XORI) ? 1 : 0;
  assign inst_lui = (OpD == `INST_LUI) ? 1 : 0;
  assign inst_lw = (OpD == `INST_LW) ? 1 : 0;
  assign inst_sw = (OpD == `INST_SW) ? 1 : 0;
  assign inst_beq = (OpD == `INST_BEQ) ? 1 : 0;
  assign inst_bne = (OpD == `INST_BNE) ? 1 : 0;

  // J-Type Instructions
  assign inst_j = (OpD == `INST_J) ? 1 : 0;
  assign inst_jal = (OpD == `INST_JAL) ? 1 : 0;

  /* --- Determine control signals --- */

  // ALUOp
  assign AluOpD =
       (inst_addi || inst_addiu || inst_add ||
        inst_addu || inst_lw    || inst_sw    ) ? `ALU_OP_ADD  : // ADD
      (inst_sub || inst_subu || inst_beq) ? `ALU_OP_SUB :  // SUB
      (inst_slt || inst_sltu || inst_sltiu) ? `ALU_OP_SLT :  // SLT
      (inst_and || inst_andi) ? `ALU_OP_AND :  // AND
      (inst_or || inst_ori) ? `ALU_OP_OR :  // OR
      (inst_xor || inst_xori) ? `ALU_OP_XOR :  // XOR
      (inst_nor) ? `ALU_OP_NOR :  // NOR
      (inst_sll) ? `ALU_OP_SLL :  // SLL
      (inst_srl) ? `ALU_OP_SRL :  // SRL
      (inst_sra) ? `ALU_OP_SRA :  // SRA
      (inst_sllv) ? `ALU_OP_SLLV :  // SLLV
      (inst_srlv) ? `ALU_OP_SRLV :  // SRLV
      (inst_srav) ? `ALU_OP_SRAV :  // SRAV
      `ALU_OP_DEFAULT;  // Default ALU operand (output the second ALU input)

  // RegDst
  assign RegDstD =
       (inst_add   || inst_addu  || inst_sub   || inst_subu  ||
        inst_slt   || inst_sltu  || inst_and   || inst_or    ||
        inst_nor   || inst_xor   || inst_sll   || inst_srl   ||
        inst_sra   || inst_sllv  || inst_srlv  || inst_srav  ||
        inst_jalr                                            ) ? `REG_DST_RD :
       (inst_lui   || inst_addi  || inst_addiu || inst_sltiu ||
        inst_andi  || inst_ori   || inst_xori  || inst_lw    ) ? `REG_DST_RT :
       (inst_jal) ? `REG_DST_REG_31 : `REG_DST_DEFAULT;
  // ALUSrc
  assign AluSrcD =
       (inst_addi  || inst_addiu || inst_sltiu || inst_andi ||
        inst_ori   || inst_xori  || inst_lw    || inst_sw   || inst_lui ) ? `ALU_SRC_IMM : `ALU_SRC_REG;

  // RegWrite
  assign RegWriteD =
       (inst_lui   || type_r     || inst_addi  || inst_addiu ||
        inst_sltiu || inst_andi  || inst_ori   || inst_xori  ||
        inst_add   || inst_addu  || inst_sub   || inst_subu  ||
        inst_slt   || inst_sltu  || inst_and   || inst_or    ||
        inst_nor   || inst_xor   || inst_sll   || inst_srl   ||
        inst_sra   || inst_sllv  || inst_srlv  || inst_srav  ||
        inst_lw    || inst_jal   || inst_jalr                ) ? `REG_WRITE_EN : `REG_WRITE_DIS;

  // MemWrite
  assign MemWriteD = (inst_sw) ? `MEM_WRITE_EN : `MEM_WRITE_DIS;

  // MemToReg
  assign MemToRegD = (inst_lw) ? `MemToReg_EN : `MemToReg_DIS;

  // LoadNPC
  assign LoadNPCD = (inst_jal || inst_jalr) ? `LoadNPC_EN : `LoadNPC_DIS;

  // ImmTypeD
  assign ImmTypeD =
      // shift left 16
      (inst_lui) ? `EXT_OP_SFT16 :
      // signed extend
      (inst_add   || inst_addu  || inst_addi  || inst_sub   || inst_subu || inst_andi || inst_slt   || inst_sltu  ||
       inst_and   || inst_or    || inst_nor   || inst_xor   ||
       inst_sll   || inst_srl   || inst_sra   || inst_sllv  ||
       inst_srlv  || inst_srav  || inst_ori   || inst_xori  || inst_beq  || inst_bne ) ? `EXT_OP_SIGNED :
      // unsigned extend
      (inst_addiu || inst_sltiu || inst_lw || inst_sw) ? `EXT_OP_UNSIGNED : `EXT_OP_DEFAULT;

  // BrTypeD
  assign BrTypeD = (inst_beq) ? 2'b01 : (inst_bne) ? 2'b10 : 2'b00;

  //JumpD
  assign JumpD = (inst_j || inst_jal) ? 1'b1 : 1'b0;

  //JrD
  assign JrD = (inst_jr || inst_jalr ) ? 1'b1 : 1'b0;

endmodule
