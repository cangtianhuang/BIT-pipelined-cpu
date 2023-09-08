`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: reg_if_id
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

module reg_if_id (
    input wire        clk,
    input wire        rst,
    input wire [31:0] PCF,
    input wire [31:0] instrF,
    input wire        JrF,
    input wire        stallID,
    input wire        flushID,

    output reg [31:0] PCD,
    output reg [31:0] instrD,
    output reg JrD
);

  always @(posedge clk) begin
    // flush: reset regs
    if (rst || flushID) begin
      instrD <= 32'h0;
      PCD <= 32'h0;
      JrD <= 1'b0;
    end else if (~stallID) begin
      instrD <= instrF;
      PCD <= PCF;
      JrD <= JrF;
    end
    // stalling: do nothing
  end

endmodule
