`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/08/27 15:22:13
// Design Name:
// Module Name: branch
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module branch (
    input wire [31:0] RegData1,
    input wire [31:0] RegData2,
    input wire [ 1:0] BrTypeE,

    output wire BrE
);
  wire equal = (RegData1 == RegData2);
  assign BrE = (BrTypeE == 2'b01 && equal) ? 1'b1 : (BrTypeE == 2'b10 && ~equal) ? 1'b1 : 1'b0;
endmodule
