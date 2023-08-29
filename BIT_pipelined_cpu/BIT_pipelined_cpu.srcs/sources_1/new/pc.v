`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: pc
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

module pc (
    input wire        clk,
    input wire        rst,
    input wire [31:0] NPC,
    input wire        stallIF,

    output reg [31:0] PC
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      PC <= 32'h0;
    end else if (~stallIF) begin
      PC <= NPC;
    end
    // stalling: do nothing
  end

endmodule
