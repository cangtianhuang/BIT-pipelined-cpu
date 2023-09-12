`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: mux...alu...
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

// Selects the number of the register that will be written to
module reg_dst_mux (
    input wire [1:0] RegDstE,
    input wire [4:0] RtE,
    input wire [4:0] RdE,

    output wire [4:0] RegWriteAddrE
);

  assign RegWriteAddrE = (RegDstE == `REG_DST_RT) ? RtE :
    (RegDstE == `REG_DST_RD) ? RdE :
    (RegDstE == `REG_DST_REG_31) ? `REG_31_ADDR : RtE;

endmodule

// Select whether the second operand of alu is register data or an immediate number.
module alu_src_mux (
    input wire        AluSrcE,
    input wire [31:0] ForwardOut,
    input wire [31:0] ImmE,

    output wire [31:0] AluInput2
);

  assign AluInput2 = (AluSrcE == `ALU_SRC_REG) ? ForwardOut : ImmE;

endmodule

// Selects whether the data that will be written to the register is the result from alu or PC4
module result_mux (
    input wire LoadNPCM,
    input wire [31:0] AluOutM,
    input wire [31:0] PCM,

    output wire [31:0] ResultM
);

  assign ResultM = (LoadNPCM == `LOADNPC_EN) ? (PCM + 32'h4) : AluOutM;

endmodule

// Select whether the data that will be written to the register is the result of the previous stage or memory
module mem_to_reg_mux (
    input wire        MemToRegW,
    input wire [31:0] ResultW,
    input wire [31:0] MemDataW,

    output wire [31:0] RegWriteDataW
);

  assign RegWriteDataW = (MemToRegW == `MEMTOREG_EN) ? MemDataW : ResultW;

endmodule

// Select register data from EX, MEM, or WB based on data forwarding signals
module forward_mux (
    input wire [ 1:0] Forward,
    input wire [31:0] ExData,
    input wire [31:0] MemData,
    input wire [31:0] WbData,

    output wire [31:0] ForwardOut
);

  assign ForwardOut = (Forward == `FORWARD_FROM_MEM) ? MemData :
    (Forward == `FORWARD_FROM_WB) ? WbData : ExData;

endmodule
