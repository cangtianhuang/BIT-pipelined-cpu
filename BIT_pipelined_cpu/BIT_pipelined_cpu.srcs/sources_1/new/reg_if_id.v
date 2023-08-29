`timescale 1ns / 1ps
`include "definitions.vh"

/*
 * Module: ZanPU IF/ID Register
 *
 * Input:  .clk .rst .pc_in .instructions_in
 * Output: .pc_out .instructions_out
 */

module reg_if_id (
    input wire        clk,
    input wire        rst,
    input wire [31:0] PCF,
    input wire [31:0] instrF,
    input wire        stallID,
    input wire        flushID,

    output reg [31:0] PCD,
    output reg [31:0] instrD
);

  always @(posedge clk) begin
    if (rst || flushID) begin
      instrD <= `INIT_32;
      PCD <= `INIT_32;
    end else if (stallID == 0) begin
      instrD <= instrF;
      PCD <= PCF;
    end else begin
      // do nothing
    end
  end

endmodule
