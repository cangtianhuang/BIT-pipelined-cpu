`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Beijing Institute Of Technology
// Engineer: Hao Yang, Xinyu Wang, Haoyang Li
//
// Create Date: 2023/08/23
// Design Name: BIT-pipelined-cpu
// Module Name: testbench
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

module testbench ();
  reg clk;
  reg rst;
  BIT_cpu cpu (
      .clk(clk),
      .rst(rst)
  );

  initial begin
    // Load instructions
    $readmemh("C:/Users/86159/Downloads/instr.mem", BIT_cpu.instruction_memory.memory);

    rst = 1;
    clk = 0;

    #30 rst = 0;
    $readmemh("C:/Users/86159/Downloads/data.mem", BIT_cpu.data_memory.memory);

    #5000 $stop;
  end

  always #20 clk = ~clk;
endmodule
