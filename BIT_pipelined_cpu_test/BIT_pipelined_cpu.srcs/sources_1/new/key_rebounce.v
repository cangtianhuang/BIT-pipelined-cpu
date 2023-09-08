`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/06 16:20:38
// Design Name:
// Module Name: key_rebounce
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


module key_rebounce (
    input clk,
    input rst,
    input key_in,
    output reg key_out
);

  // 参数定义
  parameter DEBOUNCE_COUNT = 10000;  // 防抖计数器的值

  // 内部信号定义
  reg [19:0] debounce_counter;  // 防抖计数器

  // 状态定义
  reg key_state;  // 按钮状态

  always @(posedge clk or negedge rst) begin
    if (~rst) begin
      // 复位时重置防抖计数器和按钮状态
      debounce_counter <= 0;
      key_state <= 0;
      key_out <= 0;
    end else begin
      // 检测按钮状态变化
      if (key_in != key_state) begin
        // 如果按钮状态发生变化，重置防抖计数器
        debounce_counter <= 0;
        key_state <= key_in;
      end else if (debounce_counter < DEBOUNCE_COUNT) begin
        // 如果按钮状态保持不变，且计数器未达到阈值，继续增加计数器
        debounce_counter <= debounce_counter + 1;
      end else begin
        // 如果按钮状态保持不变且计数器达到阈值，更新按钮输出
        key_out <= key_in;
      end
    end
  end

endmodule
