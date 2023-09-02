`timescale 1ns / 1ps
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

`define REG_31_ADDR     5'b11111

/* --- Instruction Decode --- */

// R-Type instructions
`define INST_R_TYPE     6'b000000  // R-Type opcode

// func code
`define FUNC_ADD        6'b100000  // ADD
`define FUNC_ADDU       6'b100001  // ADDU
`define FUNC_SUB        6'b100010  // SUB
`define FUNC_SUBU       6'b100011  // SUBU
`define FUNC_SLT        6'b101010  // SLT
`define FUNC_SLTU       6'b101011  // SLTU
`define FUNC_AND        6'b100100  // AND
`define FUNC_OR         6'b100101  // OR
`define FUNC_NOR        6'b100111  // NOR
`define FUNC_XOR        6'b100110  // XOR
`define FUNC_SLL        6'b000000  // SLL
`define FUNC_SRL        6'b000010  // SRL
`define FUNC_SRA        6'b000011  // SRA
`define FUNC_SLLV       6'b000100  // SLLV
`define FUNC_SRLV       6'b000110  // SRLV
`define FUNC_SRAV       6'b000111  // SRAV

`define FUNC_JR         6'b001000  // JR
`define FUNC_JALR       6'b001001  // JALR

// I-Type instructions
`define INST_ADDI       6'b001000  // ADDI
`define INST_ADDIU      6'b001001  // ADDIU
`define INST_SLTIU      6'b001011  // SLTIU
`define INST_ANDI       6'b001100  // ANDI
`define INST_ORI        6'b001101  // ORI
`define INST_XORI       6'b001110  // XORI
`define INST_LUI        6'b001111  // LUI
`define INST_LW         6'b100011  // LW
`define INST_SW         6'b101011  // SW
`define INST_BEQ        6'b000100  // BEQ
`define INST_BNE        6'b000101  // BNE

// J-Type instructions
`define INST_J          6'b000010  // J
`define INST_JAL        6'b000011  // JAL

/* --- Control Signals --- */

// ExtOp Control Signals
`define EXT_OP_DEFAULT  2'b00      // ExtOp default value
`define EXT_OP_SFT16    2'b01      // LUI: Shift Left 16
`define EXT_OP_SIGNED   2'b10      // ADDIU: `imm16` signed extended to 32 bit
`define EXT_OP_UNSIGNED 2'b11      // LW, SW: `imm16` unsigned extended to 32 bit

// ALUSrc Control Signals
`define ALU_SRC_REG     1'b0       // ALU source: register file
`define ALU_SRC_IMM     1'b1       // ALU Source: immediate

// ALU Control Signals
`define ALU_OP_DEFAULT  4'b0000    // ALUOp default value
`define ALU_OP_ADD      4'b0001    // ALU add
`define ALU_OP_SUB      4'b0010    // ALU sub
`define ALU_OP_SLT      4'b0011    // ALU slt
`define ALU_OP_AND      4'b0100    // ALU and
`define ALU_OP_OR       4'b0101    // ALU or
`define ALU_OP_XOR      4'b0110    // ALU xor
`define ALU_OP_NOR      4'b0111    // ALU nor
`define ALU_OP_SLL      4'b1000    // ALU sll, with respect to sa
`define ALU_OP_SRL      4'b1001    // ALU srl, with respect to sa
`define ALU_OP_SRA      4'b1010    // ALU sra, with respect to sa
`define ALU_OP_SLLV     4'b1011    // ALU sllv, with respect to rs
`define ALU_OP_SRLV     4'b1100    // ALU srlv, with respect to rs
`define ALU_OP_SRAV     4'b1101    // ALU srav, with respect to rs

// MemToReg Control Signals
`define MEMTOREG_EN     1'b1      // Register write source: Data Memory
`define MEMTOREG_DIS    1'b0      // Register write source: Result(ALU or PC+4)

// LoadNPC Control Signals
`define LOADNPC_EN      1'b1      // Register write source(without MEM): PC+4
`define LOADNPC_DIS     1'b0      // Register write source(without MEM): ALU

// RegDst Control Signals
`define REG_DST_DEFAULT 2'b00      // Register write destination: default
`define REG_DST_RT      2'b01      // Register write destination: Rt
`define REG_DST_RD      2'b10      // Register write destination: Rd
`define REG_DST_REG_31  2'b11      // Register write destination: $31

/* --- Hazard Control --- */

// Forward Control Signals
`define FORWARD_DEFAULT  2'b00     // No forward
`define FORWARD_FROM_MEM 2'b10     // forwarding from MEM (one cycle)
`define FORWARD_FROM_WB  2'b01     // forwarding from WB (two cycles)

`define BRTYPE_DEFAULT   2'b00     // No branch
`define BRTYPE_BEQ       2'b01     // branch equal
`define BRTYPE_BNE       2'b10     // branch not equal
