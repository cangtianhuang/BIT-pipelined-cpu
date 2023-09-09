`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/06 16:20:38
// Design Name:
// Module Name: light_control
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


module light_control (
    input clk,
    input rst,
    input [15:0] data,
    output [7:0] LEDControl,
    output [3:0] LEDIndex
);

  //寄存数码管信号和分段、暂留计数
  reg [ 3:0] index_temp;
  reg [ 3:0] control_temp;
  reg [31:0] counter;
  //定义计数峰值（暂留时间）和分段信号（共四位）
  parameter count_max = 10000;
  parameter A = 4'b1000, B = 4'b0100, C = 4'b0010, D = 4'b0001;

  always @(posedge clk or negedge rst) begin
    if (~rst) begin
      index_temp <= D;
      control_temp <= 0;
      counter <= 0;
    end else if (counter == count_max) begin
      //暂留后分段转移
      case (index_temp)
        A: begin
          index_temp   <= D;
          control_temp <= data[3:0];
        end
        B: begin
          index_temp   <= A;
          control_temp <= data[15:12];
        end
        C: begin
          index_temp   <= B;
          control_temp <= data[11:8];
        end
        D: begin
          index_temp   <= C;
          control_temp <= data[7:4];
        end
        default: begin
          index_temp   <= D;
          control_temp <= data[3:0];
        end
      endcase
      counter <= 0;
    end else begin
      counter <= counter + 1;
    end
  end

  //显示不同数字和小数点
  assign LEDControl[0] = (control_temp == 1 || control_temp == 4) ? 0 : 1;
  assign LEDControl[1] = (control_temp == 5 || control_temp == 6) ? 0 : 1;
  assign LEDControl[2] = (control_temp == 2) ? 0 : 1;
  assign LEDControl[3] = (control_temp == 1 || control_temp == 4 || control_temp == 7) ? 0 : 1;
  assign LEDControl[4] = (control_temp == 0 || control_temp == 2 || control_temp == 6 || control_temp == 8)? 1:0;
  assign LEDControl[5] = (control_temp == 1 || control_temp == 2 || control_temp == 3 || control_temp == 7)? 0:1;
  assign LEDControl[6] = (control_temp == 0 || control_temp == 1 || control_temp == 7) ? 0 : 1;
  assign LEDControl[7] = 0;

  assign LEDIndex = index_temp;

endmodule
