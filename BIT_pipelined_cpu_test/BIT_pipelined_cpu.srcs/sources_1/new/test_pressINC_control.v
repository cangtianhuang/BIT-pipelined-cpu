`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/06 15:54:00
// Design Name:
// Module Name: test_pressINC_control
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


module test_pressINC_control (
    input sys_clk,
    input sys_rst,
    input key,
    output [7:0] LEDControl,
    output [3:0] LEDIndex
);

  reg clk = 0;
  reg [3:0] clk_count = 0;
  always @(posedge sys_clk) begin
    if (clk_count >= 10) begin
      clk = ~clk;
      clk_count = 0;
    end else clk_count = clk_count + 1;
  end

  wire press_on;

  key_rebounce key_rebounce (
      .clk    (clk),
      .rst    (sys_rst),
      .key_in (key),
      .key_out(press_on)
  );

  wire [11:2] WordAddr;
  wire        WordWrite;
  wire [31:0] WriteWord;
  wire [31:0] ReadWord;

  reg         prev_press_on = 1;

  assign WordWrite = (press_on ^ prev_press_on) ? 1 : 0;
  assign WordAddr  = (WordWrite) ? 0 : 1;
  assign WriteWord = press_on;

  always @(posedge clk) begin
    prev_press_on <= press_on;
  end

  BIT_cpu BIT_cpu (
      .clk      (clk),
      .rst      (~sys_rst),
      .WordAddr (WordAddr),
      .WordWrite(WordWrite),
      .WriteWord(WriteWord),
      .ReadWord (ReadWord)
  );

  reg [31:0] bdata;
  reg [15:0] idata;

  integer i;

  always @(*) begin
    bdata = ReadWord;
    idata = 0;
    for (i = 13; i >= 0; i = i - 1) begin
      if (idata[3:0] >= 4'd5) idata[3:0] = idata[3:0] + 4'd3;
      if (idata[7:4] >= 4'd5) idata[7:4] = idata[7:4] + 4'd3;
      if (idata[11:8] >= 4'd5) idata[11:8] = idata[11:8] + 4'd3;
      if (idata[15:12] >= 4'd5) idata[15:12] = idata[15:12] + 4'd3;
      idata[15:12] = {idata[14:12], idata[11]};
      idata[11:8]  = {idata[10:8], idata[7]};
      idata[7:4]   = {idata[6:4], idata[3]};
      idata[3:0]   = {idata[2:0], bdata[i]};
    end
  end


  light_control light_control (
      .clk       (clk),
      .rst       (sys_rst),
      .data      (idata),
      .LEDControl(LEDControl),
      .LEDIndex  (LEDIndex)
  );

endmodule
