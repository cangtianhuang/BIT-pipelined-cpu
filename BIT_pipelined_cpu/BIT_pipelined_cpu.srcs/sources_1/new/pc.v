`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU PC
 *
 * Input:  .clk .rst .npc
 * Output: .pc
 */

module pc (
    input wire        clk,
    input wire        rst,
    input wire [31:0] NPC,
    input wire        stallIF,

    output reg [31:0] PC
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      PC <= `INIT_32;
    end else if (stallIF == 0) begin
      PC <= NPC;
    end
  end
endmodule
