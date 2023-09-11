`timescale 1ns / 1ps
`include "params.vh"

module top_vga (
    input wire       clk,
    input wire       rst,

    output wire      hs,
   output wire      vs,
   output wire[3:0] red,
   output wire[3:0] green,
   output wire[3:0] blue
);

wire cpu_clk;
change_clk changer(
    .clk(clk),
    .rst(~rst),
    .out_clk(cpu_clk)
);


BIT_cpu BIT_cpu(
    .clk(cpu_clk),
    .rst(~rst)
);

wire[1:0] control;
reg[31:0] data_in;
assign control=2'b01;

wire clk_vga;
clk_wiz_0 u_clk_wiz (
            // Clock out ports
            .clk_out1(clk_vga),     // output clk_out1
            // Status and control signals
            .reset(~rst ), // input reset
            // Clock in ports
            .clk_in1(clk));      // input clk_in1

reg[7:0] addr;
always @(posedge clk_vga) begin
    if(rst==`RST_EN)begin
       addr <= 0;
    end
    else begin 
       data_in <= BIT_cpu.data_memory.memory[addr];
       addr <= addr+1;
    end
end


vga vga(
    .clk(clk),
    .rst(rst),

    .control(control),
    .data_in(data_in),
    .addr_s(addr),

    .hs(hs),
    .vs(vs),
    .red(red),
    .green(green),
    .blue(blue)
);


endmodule