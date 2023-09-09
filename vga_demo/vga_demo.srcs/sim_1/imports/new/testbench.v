`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/31 15:05:17
// Design Name: 
// Module Name: test_vga
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


module test_vga();
  reg clk;
  reg rst;
  
  wire      hs;
wire      vs;
wire[3:0] red;
wire[3:0] green;
wire[3:0] blue;
  
  top_vga top(
    .clk(clk),
           .rst(rst),

           .hs(hs),
           .vs(vs),
           .red(red),
           .green(green),
           .blue(blue)
  );

  initial begin
    // Load instructions
//    $readmemh("C:/Users/ASUS/Desktop/BIT_pipelined_cpu/testcode/instr.mem", top.BIT_cpu.instruction_memory.memory);

    rst = 0;
    clk = 0;

    #37 rst = 1;
//    $readmemh("C:/Users/ASUS/Desktop/BIT_pipelined_cpu/testcode/data.mem", top.BIT_cpu.data_memory.memory);

    #50000000 $stop;
  end

  always #5 clk = ~clk;
endmodule
