`timescale 1ns / 1ps

/*
 * Testbench
 */

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
