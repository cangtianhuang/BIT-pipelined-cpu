`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: register_file
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

module register_file (
    input wire       clk,
    input wire       rst,
    input wire [4:0] RsD,
    input wire [4:0] RtD,

    input wire        RegWriteW,      // enable register write
    input wire [ 4:0] RegWriteAddrW,  // selected reg from WB
    input wire [31:0] RegWriteDataW,  // write reg data from WB

    output wire [31:0] RegOut1D, // RsData
    output wire [31:0] RegOut2D  // RtData
);

  reg [31:0] regs[31:0];
  integer i;

  // Get register data from regs
  assign RegOut1D = regs[RsD];
  assign RegOut2D = regs[RtD];

  // Write data back to register (in negedge!!!)
  always @(negedge clk) begin
    if (rst) begin
      for (i = 0; i < 32; i = i + 1) begin
        regs[i] <= 32'h0;
      end
    end else if (RegWriteW && (|RegWriteAddrW)) begin // prohibit to write $zero
      regs[RegWriteAddrW] = RegWriteDataW;
    end
  end

endmodule
