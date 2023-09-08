`timescale 1ns / 1ps
`include "definitions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: branch
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

module branch (
    input wire [31:0] RegData1,
    input wire [31:0] RegData2,
    input wire [ 1:0] BrTypeE,

    output wire BrE
);

  wire equal = (RegData1 == RegData2);

  assign BrE = (BrTypeE == `BRTYPE_BEQ && equal) ? 1'b1 :
    (BrTypeE == `BRTYPE_BNE && ~equal) ? 1'b1 : 1'b0;

endmodule
