`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/06 21:02:27
// Design Name:
// Module Name: testbench_pressINC
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


module testbench_pressINC ();
  reg clk;
  reg rst;
  reg key;
  wire [7:0] LEDControl;
  wire [3:0] LEDIndex;

  test_pressINC_control test_pressINC_control (
      .sys_clk(clk),
      .sys_rst(rst),
      .key(key),
      .LEDControl(LEDControl),
      .LEDIndex(LEDIndex)
  );

  initial begin
    // Load instructions
    $readmemh("C:/Users/86159/Downloads/instr_press.mem", test_pressINC_control.BIT_cpu.instruction_memory.memory);

    rst = 0;
    clk = 0;
    key = 0;

    #100
    rst = 1;

    #1000
    key=1;
    #1000
    key=0;

    #1000
    key=1;
    #1000
    key=0;

    #1000
    key=1;
    #1000
    key=0;

    #1000
    key=1;
    #100
    key=0;
    #100
    key=1;
    #100
    key=0;

    #1000 $stop;
  end

  always #20 clk = ~clk;
endmodule
