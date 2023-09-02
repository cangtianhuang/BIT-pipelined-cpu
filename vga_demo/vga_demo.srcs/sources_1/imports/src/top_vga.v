`timescale 1ns / 1ps

module top_vga (
    input wire       clk,
    input wire       rst,

    output wire      hs,
   output wire      vs,
   output wire[3:0] red,
   output wire[3:0] green,
   output wire[3:0] blue
);

BIT_cpu BIT_cpu(
    .clk(clk),
    .rst(rst)
);

wire[1:0] control;
reg[31:0] data_in;
reg[9:0] addrs;
assign control[0]=1;

wire clk_vga;
clk_wiz_0 u_clk_wiz (
            // Clock out ports
            .clk_out1(clk_vga),     // output clk_out1
            // Status and control signals
            .reset(rst ), // input reset
            // Clock in ports
            .clk_in1(clk));      // input clk_in1

reg[9:0] addr;
always @(posedge clk_vga) begin
    if(rst)begin
       addr <= 0;
    end
    else begin 
       data_in <= BIT_cpu.data_memory.memory[addr];
       addr <= addr+1;
    end
end

wire hs;
wire vs;
wire[3:0] red;
wire[3:0] green;
wire[3:0] blue;

vga vga(
    .clk_vga(clk_vga),
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