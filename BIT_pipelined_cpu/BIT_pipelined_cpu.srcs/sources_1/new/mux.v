`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU Multiplexers
 */

module reg_dst_mux (
    input wire [1:0] RegDstE,
    input wire [4:0] RtE,
    input wire [4:0] RdE,

    output wire [4:0] RegWriteAddrE
);

  assign RegWriteAddrE =
       (RegDstE == `REG_DST_RT    ) ? RtE :
       (RegDstE == `REG_DST_RD    ) ? RdE :
       (RegDstE == `REG_DST_REG_31) ? `REG_31_ADDR :
       RtE;
endmodule

module alu_src_mux (
    input wire        AluSrcE,
    input wire [31:0] ForwardOut,
    input wire [31:0] ImmE,

    output wire [31:0] AluInput2
);

  assign AluInput2 = (AluSrcE == `ALU_SRC_REG) ? ForwardOut : ImmE;
endmodule

module result_mux (
    input wire LoadNPCM,
    input wire [31:0] AluOutM,
    input wire [31:0] PCM,

    output wire [31:0] ResultM
);

  assign ResultM = (LoadNPCM == `LoadNPC_EN) ? (PCM + 32'h4) : AluOutM;
endmodule

module mem_to_reg_mux (
    input wire        MemToRegW,
    input wire [31:0] ResultW,
    input wire [31:0] MemDataW,

    output wire [31:0] RegWriteDataW
);

  assign RegWriteDataW = (MemToRegW == `MemToReg_EN) ? MemDataW : ResultW;
endmodule

module forward_mux (
    input wire [ 1:0] Forward,
    input wire [31:0] ExData,
    input wire [31:0] MemData,
    input wire [31:0] WbData,

    output wire [31:0] ForwardOut
);

  assign ForwardOut = (Forward == 2'b10) ? MemData : (Forward == 2'b01) ? WbData : ExData;
endmodule

module jump_alu (
    input wire [31:0] PCD,
    input wire [25:0] Addr,

    output wire [31:0] JumpNPC
);

  assign JumpNPC = {PCD[31:28], Addr, 2'b00};
endmodule

module branch_alu (
    input wire [31:0] PC,
    input wire [31:0] Imm,

    output wire [31:0] BrNPC
);

  assign BrNPC = PC + 32'h4 + (Imm << 2);

endmodule
