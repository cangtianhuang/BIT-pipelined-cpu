`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/05 18:29:48
// Design Name: 
// Module Name: change_clk
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


module change_clk(
    input wire clk,
    input wire rst,
    output wire out_clk
    );
    
    reg [5:0] counter;
    reg out_c;
    assign out_clk=out_c;
    
    always @(posedge clk)begin
        if(rst)begin
            out_c<=0;
            counter<=0;
        end
        else begin
            if(counter==0)begin
                out_c <= ~out_c;
            end
                counter <= counter+1;
        end
    end
    
endmodule
