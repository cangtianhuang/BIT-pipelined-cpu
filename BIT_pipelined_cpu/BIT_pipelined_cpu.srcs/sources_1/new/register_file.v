`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU Register File
 *
 * Input:
 * Output:
 */

module register_file (
    input wire       clk,
    input wire       rst,
    input wire [4:0] RsD,
    input wire [4:0] RtD,

    input wire        RegWriteW,      // enable register write
    input wire [ 4:0] RegWriteAddrW,  // rs or rd, defined in WB stage
    input wire [31:0] RegWriteDataW,  // write data back to dest reg

    output wire [31:0] RegOut1D,
    output wire [31:0] RegOut2D
);

  // Register file general purpose register
  reg [31:0] regs[31:0];
  integer i;

  // Get register data from regs
  assign RegOut1D = regs[RsD];
  assign RegOut2D = regs[RtD];

  // Write data back to register
  always @(negedge clk) begin
    if (rst) begin
      for (i = 0; i < 32; i = i + 1) begin
        regs[i] <= `INIT_32;
      end
    end else if (RegWriteW && (|RegWriteAddrW)) begin
      regs[RegWriteAddrW] = RegWriteDataW;
    end
  end

endmodule
