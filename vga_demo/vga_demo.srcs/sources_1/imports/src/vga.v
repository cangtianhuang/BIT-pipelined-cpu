`timescale 1ns / 1ps
`include "params.vh"

module vga #(
           parameter H_DISPLAY      = 11'd1024,
           parameter H_FRONT_PORCH  = 11'd24,
           parameter H_SYNC_PULSE   = 11'd136,
           parameter H_BACK_PORCH   = 11'd160,
           parameter H_TOTAL        = 11'd1344,

           parameter V_DISPLAY      = 10'd768,
           parameter V_FRONT_PORCH  = 10'd3,
           parameter V_SYNC_PULSE   = 10'd6,
           parameter V_BACK_PORCH   = 10'd29,
           parameter V_TOTAL        = 10'd806
       )(
           input  wire      clk_vga,
           input  wire      rst,
           
           input wire[1:0] control,
           input wire [31:0] data_in,
           input wire [9:0] addr_s,

           output wire      hs,
           output wire      vs,
           output wire[3:0] red,
           output wire[3:0] green,
           output wire[3:0] blue
    );

wire rdata=1'b0;

reg[31:0] data[31:0];



reg[4:0] p_x;
reg[4:0] p_y;
reg[31:0] player_x;  

/* --- Initialize map --- */

always @ (posedge clk_vga) begin
    if (rst == `RST_EN) begin
        data[0]  <= 32'h00000000;
        data[1]  <= 32'h15545518;
        data[2]  <= 32'h10040110;
        data[3]  <= 32'h11555510;
        data[4]  <= 32'h11100010;
        data[5]  <= 32'h11155554;
        data[6]  <= 32'h11000000;
        data[7]  <= 32'h11555454;
        data[8]  <= 32'h10000444;
        data[9]  <= 32'h15554444;
        data[10] <= 32'h01000444;
        data[11] <= 32'h15555444;
        data[12] <= 32'h10010044;
        data[13] <= 32'h15515554;
        data[14] <= 32'h30100000;
        data[15] <= 32'h00000000;
        p_x <= 5'b00000;
        p_y <= 5'b00000;
        player_x <= 32'h00000000;
    end
end

/* --- Write data to VGA Driver memory --- */

always @ (posedge clk_vga)  begin
    if (control[0]) begin
        data[addr_s] <= data_in;
    end
end

/* --- VGA Driver --- */

/* RGB signals */
wire hs;
wire vs;
reg[3:0] reg_red;
reg[3:0] reg_green;
reg[3:0] reg_blue;

assign red = reg_red;
assign green = reg_green;
assign blue = reg_blue;

/* Horizonal & Vertical refresh pulses */

reg h_reg;
reg v_reg;

assign hs = h_reg;
assign vs = v_reg;

reg[10:0] h_count;
reg[10:0] v_count;

/* horizontal scan and vertical scan */

always @ (posedge clk_vga) begin
    if (rst == `RST_EN) begin
        h_count <= 11'b0;
        v_count <= 11'b0;
    end
    else begin
        if (h_count == H_TOTAL - 1) begin
            h_count <= 11'b0;
            if (v_count == V_TOTAL - 1) begin
                v_count <= 11'b0;
            end
            else begin
                v_count <= v_count + 1'b1;
            end
        end
        else begin
            h_count <= h_count + 1'b1;
        end
    end
end

always @ (posedge clk_vga) begin
    if (h_count < H_SYNC_PULSE) begin
        h_reg <= 1'b0;
    end
    else begin
        h_reg <= 1'b1;
    end
end

always @ (posedge clk_vga) begin
    if (v_count < V_SYNC_PULSE) begin
        v_reg <= 1'b0;
    end
    else begin
        v_reg <= 1'b1;
    end
end

/* --- Render Map --- */

always @ (posedge clk_vga) begin
    player_x <= data[addr_s];
    p_x <= addr_s[9:5];
    p_y <= addr_s[4:0];
end

/* --- Control RGB --- */
reg[3:0] red_in, green_in, blue_in;
reg[10:0] v_low;
reg[10:0] v_high;
reg[10:0] h_low;
reg[10:0] h_high;
always @ (posedge clk_vga) begin
    // decode 
    red_in<=player_x[11:8];
    green_in<=player_x[7:4];
    blue_in<=player_x[3:0];
    // render according to position
    if (h_count < 1140 && h_count > 500 && v_count < 740 && v_count > 100) begin
        v_low <= 500+p_x*20;
        v_high <=520+p_x*20;
        h_low <=100+p_y*20;
        h_high <=120+p_y*20;
        if(h_count>h_low&&h_count<h_high&&v_count>v_low&&v_high<v_high)begin
            reg_red <= red_in;
            reg_green <= green_in;
            reg_blue <= blue_in;
        end
    end
    else begin
        reg_red   <= `WHITE_R;
        reg_green <= `WHITE_G;
        reg_blue  <= `WHITE_B;
    end
end
endmodule
