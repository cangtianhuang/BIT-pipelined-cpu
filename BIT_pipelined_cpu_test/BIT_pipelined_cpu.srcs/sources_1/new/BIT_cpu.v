`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/25
// Design Name: BIT-pipelined-cpu
// Module Name: BIT_cpu
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

module BIT_cpu (
    input wire clk,
    input wire rst,

    input  wire [11:2] WordAddr,
    input  wire        WordWrite,
    input  wire [31:0] WriteWord,
    output wire [31:0] ReadWord
);

  /*
 * Instantiate modules
 */

  /* --- Stage 1: Instruction Fetch --- */

  /* pc, npc and instr_memory */

  wire [4:0] RsD;
  wire [4:0] RtD;
  wire [4:0] RegWriteAddrE;
  wire AluSrcD;
  wire MemToRegE;
  wire JrD;
  wire JrE;
  wire BrE;
  wire [1:0] BrTypeE;
  wire stallIF;
  wire stallID;
  wire flushID;
  wire flushEX;

  hazard_unit hazard_unit (
      .RsD          (RsD),
      .RtD          (RtD),
      .AluSrcD      (AluSrcD),
      .MemToRegE    (MemToRegE),
      .RegWriteAddrE(RegWriteAddrE),
      .JrD          (JrD),
      .JrE          (JrE),
      .BrE          (BrE),
      .BrTypeE      (BrTypeE),
      .stallIF      (stallIF),
      .stallID      (stallID),
      .flushID      (flushID),
      .flushEX      (flushEX)
  );

  wire [31:0] ForwardData1;
  wire [31:0] PCE;
  wire [31:0] JumpNPCF;
  wire [31:0] NPC;

  npc npc (
      .BrTypeE (BrTypeE),
      .BrE     (BrE),
      .JrE     (JrE),
      .JrNPC   (ForwardData1),
      .PCE     (PCE),
      .JumpNPCF(JumpNPCF),
      .NPC     (NPC)
  );

  wire [31:0] PCF;

  pc pc (
      .clk    (clk),
      .rst    (rst),
      .NPC    (NPC),
      .stallIF(stallIF),
      .PC     (PCF)
  );

  wire [31:0] instrF;

  instruction_memory instruction_memory (
      .instr_addr(PCF[11:2]),
      .instr     (instrF)
  );

  wire [5:0] OpF;
  wire [5:0] FunctF;
  wire [25:0] AddrF;
  wire [15:0] Imm16F;
  wire JrF;

  assign OpF = instrF[31:26];
  assign FunctF = instrF[5:0];
  assign AddrF = instrF[25:0];
  assign Imm16F = instrF[15:0];

  direct_jump direct_jump (
      .OpF     (OpF),
      .FunctF  (FunctF),
      .AddrF   (AddrF),
      .Imm16F  (Imm16F),
      .PCF     (PCF),
      .JumpNPCF(JumpNPCF),
      .JrF     (JrF)
  );

  /* if/id register */

  wire [31:0] instrD;
  wire [31:0] PCD;

  reg_if_id reg_if_id (
      .clk    (clk),
      .rst    (rst),
      .PCF    (PCF),
      .instrF (instrF),
      .JrF    (JrF),
      .stallID(stallID),
      .flushID(flushID),

      .PCD   (PCD),
      .instrD(instrD),
      .JrD (JrD)
  );

  /* --- Stage 2: Instruction Decode --- */

  wire [ 5:0] OpD;
  wire [ 5:0] FunctD;
  wire [ 4:0] RdD;
  wire [ 4:0] ShamtD;
  wire [15:0] Imm16D;

  // Assign decoded instr to variables
  assign OpD    = instrD[31:26];
  assign FunctD = instrD[5:0];
  assign RsD    = instrD[25:21];
  assign RtD    = instrD[20:16];
  assign RdD    = instrD[15:11];
  assign ShamtD = instrD[10:6];
  assign Imm16D  = instrD[15:0];

  wire       RegWriteD;
  wire [1:0] ImmTypeD;
  wire [3:0] AluOpD;
  wire       MemWriteD;
  wire       MemToRegD;
  wire [1:0] RegDstD;
  wire [1:0] BrTypeD;
  wire       LoadNPCD;

  control_unit control_unit (
      .OpD      (OpD),
      .FunctD   (FunctD),
      .RegWriteD(RegWriteD),
      .ImmTypeD (ImmTypeD),
      .AluSrcD  (AluSrcD),
      .AluOpD   (AluOpD),
      .MemWriteD(MemWriteD),
      .MemToRegD(MemToRegD),
      .RegDstD  (RegDstD),
      .BrTypeD  (BrTypeD),
      .LoadNPCD (LoadNPCD)
  );

  wire        RegWriteW;
  wire [ 4:0] RegWriteAddrW;
  wire [31:0] RegWriteDataW;
  wire [31:0] RegOut1D;
  wire [31:0] RegOut2D;

  register_file register_file (
      .clk          (clk),
      .rst          (rst),
      .RsD          (RsD),
      .RtD          (RtD),
      .RegWriteW    (RegWriteW),
      .RegWriteAddrW(RegWriteAddrW),
      .RegWriteDataW(RegWriteDataW),
      .RegOut1D     (RegOut1D),
      .RegOut2D     (RegOut2D)
  );

  wire [31:0] ImmD;

  extend extend (
      .Imm16   (Imm16D),
      .ImmTypeD(ImmTypeD),
      .ImmD    (ImmD)
  );

  wire [31:0] RegOut1E;
  wire [31:0] RegOut2E;
  wire [ 4:0] RsE;
  wire [ 4:0] RtE;
  wire [ 4:0] RdE;
  wire [ 4:0] ShamtE;
  wire [31:0] ImmE;
  wire        RegWriteE;
  wire        MemReadE;
  wire        AluSrcE;
  wire [ 3:0] AluOpE;
  wire        MemWriteE;
  wire [ 1:0] RegDstE;
  wire        LoadNPCE;

  reg_id_ex reg_id_ex (
      .clk      (clk),
      .rst      (rst),
      .PCD      (PCD),
      .RegOut1D (RegOut1D),
      .RegOut2D (RegOut2D),
      .RsD      (RsD),
      .RtD      (RtD),
      .RdD      (RdD),
      .ShamtD   (ShamtD),
      .ImmD     (ImmD),
      .RegWriteD(RegWriteD),
      .AluSrcD  (AluSrcD),
      .AluOpD   (AluOpD),
      .MemWriteD(MemWriteD),
      .MemToRegD(MemToRegD),
      .RegDstD  (RegDstD),
      .BrTypeD  (BrTypeD),
      .JrD      (JrD),
      .LoadNPCD (LoadNPCD),
      .flushEX  (flushEX),

      .PCE      (PCE),
      .RegOut1E (RegOut1E),
      .RegOut2E (RegOut2E),
      .RsE      (RsE),
      .RtE      (RtE),
      .RdE      (RdE),
      .ShamtE   (ShamtE),
      .ImmE     (ImmE),
      .RegWriteE(RegWriteE),
      .AluSrcE  (AluSrcE),
      .AluOpE   (AluOpE),
      .MemWriteE(MemWriteE),
      .MemToRegE(MemToRegE),
      .RegDstE  (RegDstE),
      .BrTypeE  (BrTypeE),
      .JrE      (JrE),
      .LoadNPCE (LoadNPCE)
  );

  /* --- Stage 3: Execution --- */

  wire [31:0] ForwardData2;

  reg_dst_mux reg_dst_mux (
      .RegDstE      (RegDstE),
      .RtE          (RtE),
      .RdE          (RdE),
      .RegWriteAddrE(RegWriteAddrE)
  );

  wire [31:0] AluInput2;

  alu_src_mux alu_src_mux (
      .AluSrcE   (AluSrcE),
      .ForwardOut(ForwardData2),
      .ImmE      (ImmE),
      .AluInput2 (AluInput2)
  );

  wire [31:0] AluOutE;

  alu alu (
      .AluInput1(ForwardData1),
      .AluInput2(AluInput2),
      .Shamt    (ShamtE),
      .AluOp    (AluOpE),
      .AluOut   (AluOutE),
      .overflow (overflow)
  );

  branch branch (
      .RegData1(ForwardData1),
      .RegData2(AluInput2),
      .BrTypeE (BrTypeE),
      .BrE     (BrE)
  );


  wire [1:0] ForwardRs;
  wire [1:0] ForwardRt;

  // control signals to be forwarded to MEM stage
  wire       RegWriteM;
  wire       MemToRegM;
  wire [4:0] RegWriteAddrM;

  forwarding_unit forwarding_unit (
      .RegWriteM    (RegWriteM),
      .RegWriteW    (RegWriteW),
      .RegWriteAddrM(RegWriteAddrM),
      .RegWriteAddrW(RegWriteAddrW),
      .MemToRegM    (MemToRegM),
      .RsE          (RsE),
      .RtE          (RtE),
      .ForwardRs    (ForwardRs),
      .ForwardRt    (ForwardRt)
  );

  wire [31:0] ResultM;

  forward_mux forward_mux_rs (
      .Forward   (ForwardRs),
      .ExData    (RegOut1E),
      .MemData   (ResultM),
      .WbData    (RegWriteDataW),
      .ForwardOut(ForwardData1)
  );

  forward_mux forward_mux_rt (
      .Forward   (ForwardRt),
      .ExData    (RegOut2E),
      .MemData   (ResultM),
      .WbData    (RegWriteDataW),
      .ForwardOut(ForwardData2)
  );

  wire [31:0] PCM;
  wire [31:0] AluOutM;
  wire [31:0] MemWriteDataM;
  wire        MemWriteM;
  wire        MemReadM;
  wire        LoadNPCM;

  reg_ex_mem reg_ex_mem (
      .clk          (clk),
      .rst          (rst),
      .PCE          (PCE),
      .AluOutE      (AluOutE),
      .MemWriteDataE(ForwardData2),
      .RegWriteAddrE(RegWriteAddrE),
      .MemWriteE    (MemWriteE),
      .MemToRegE    (MemToRegE),
      .RegWriteE    (RegWriteE),
      .LoadNPCE     (LoadNPCE),

      .PCM          (PCM),
      .AluOutM      (AluOutM),
      .MemWriteDataM(MemWriteDataM),
      .RegWriteAddrM(RegWriteAddrM),
      .MemWriteM    (MemWriteM),
      .MemToRegM    (MemToRegM),
      .RegWriteM    (RegWriteM),
      .LoadNPCM     (LoadNPCM)
  );

  /* --- Stage 4: Memory --- */

  result_mux result_mux (
      .LoadNPCM(LoadNPCM),
      .AluOutM (AluOutM),
      .PCM     (PCM),
      .ResultM (ResultM)
  );

  wire [31:0] ReadMemDataM;

  data_memory data_memory (
      .clk         (clk),
      .rst         (rst),
      .MemWrite    (MemWriteM),
      .MemRead     (MemToRegM),
      .MemAddr     (AluOutM[11:2]),
      .WriteMemData(MemWriteDataM),
      .ReadMemData (ReadMemDataM),

      .WordAddr (WordAddr),
      .WordWrite(WordWrite),
      .WriteWord(WriteWord),
      .ReadWord (ReadWord)
  );

  wire [31:0] ResultW;
  wire [31:0] ReadMemDataW;
  wire        MemToRegW;

  reg_mem_wb reg_mem_wb (
      .clk          (clk),
      .rst          (rst),
      .ResultM      (ResultM),
      .ReadMemDataM (ReadMemDataM),
      .RegWriteAddrM(RegWriteAddrM),
      .MemToRegM    (MemToRegM),
      .RegWriteM    (RegWriteM),

      .ResultW      (ResultW),
      .ReadMemDataW (ReadMemDataW),
      .RegWriteAddrW(RegWriteAddrW),
      .MemToRegW    (MemToRegW),
      .RegWriteW    (RegWriteW)
  );

  /* --- Stage 5: Writeback --- */
  mem_to_reg_mux mem_to_reg_mux (
      .MemToRegW(MemToRegW),
      .ResultW(ResultW),
      .MemDataW(ReadMemDataW),
      .RegWriteDataW(RegWriteDataW)
  );

endmodule
