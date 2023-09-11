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
           input  wire      clk,
           input  wire      rst,
           
           input  wire [1:0] control,
           input  wire [31:0] data_in,
           input  wire [7:0] addr_s,

           output wire      hs,
           output wire      vs,
           output wire [3:0] red,
           output wire [3:0] green,
           output wire [3:0] blue
    );
reg[31:0] data[0:255];

reg[3:0] p_x;
reg[3:0] p_y;
reg[31:0] player_x;

//wire data_in=32'h11111111;
//wire[1:0] control;
//wire [7:0] addr_s=8'b00010001;

// 65 MHz clock signal

wire clk_vga;

clk_wiz_0 u_clk_wiz (
            // Clock out ports
            .clk_out1(clk_vga),     // output clk_out1
            // Status and control signals
            .reset(~rst), // input reset
            // Clock in ports
            .clk_in1(clk));      // input clk_in1

/* --- Initialize map --- */
always @ (posedge clk_vga) begin
    if (rst == `RST_EN) begin
       data[0]  <= 32'hffffffff;
data[1]  <= 32'hffffffff;
data[2]  <= 32'hffffffff;
data[3]  <= 32'hffffffff;
data[4]  <= 32'hffffffff;
data[5]  <= 32'hffffffff;
data[6]  <= 32'hffffffff;
data[7]  <= 32'hffffffff;
data[8]  <= 32'hffffffff;
data[9]  <= 32'hffffffff;
data[10]  <= 32'hffffffff;
data[11]  <= 32'hffffffff;
data[12]  <= 32'hffffffff;
data[13]  <= 32'hffffffff;
data[14]  <= 32'hffffffff;
data[15]  <= 32'hffffffff;
data[16]  <= 32'hffffffff;
data[17]  <= 32'hffffffff;
data[18]  <= 32'hffffffff;
data[19]  <= 32'hffffffff;
data[20]  <= 32'hffffffff;
data[21]  <= 32'hffffffff;
data[22]  <= 32'hffffffff;
data[23]  <= 32'hffffffff;
data[24]  <= 32'hffffffff;
data[25]  <= 32'hffffffff;
data[26]  <= 32'hffffffff;
data[27]  <= 32'hffffffff;
data[28]  <= 32'hffffffff;
data[29]  <= 32'hffffffff;
data[30]  <= 32'hffffffff;
data[31]  <= 32'hffffffff;
data[32]  <= 32'hffffffff;
data[33]  <= 32'hffffffff;
data[34]  <= 32'hffffffff;
data[35]  <= 32'hffffffff;
data[36]  <= 32'hffffffff;
data[37]  <= 32'hffffffff;
data[38]  <= 32'hffffffff;
data[39]  <= 32'hffffffff;
data[40]  <= 32'hffffffff;
data[41]  <= 32'hffffffff;
data[42]  <= 32'hffffffff;
data[43]  <= 32'hffffffff;
data[44]  <= 32'hffffffff;
data[45]  <= 32'hffffffff;
data[46]  <= 32'hffffffff;
data[47]  <= 32'hffffffff;
data[48]  <= 32'hffffffff;
data[49]  <= 32'hffffffff;
data[50]  <= 32'hffffffff;
data[51]  <= 32'hffffffff;
data[52]  <= 32'hffffffff;
data[53]  <= 32'hffffffff;
data[54]  <= 32'hffffffff;
data[55]  <= 32'hffffffff;
data[56]  <= 32'hffffffff;
data[57]  <= 32'hffffffff;
data[58]  <= 32'hffffffff;
data[59]  <= 32'hffffffff;
data[60]  <= 32'hffffffff;
data[61]  <= 32'hffffffff;
data[62]  <= 32'hffffffff;
data[63]  <= 32'hffffffff;
data[64]  <= 32'hffffffff;
data[65]  <= 32'hffffffff;
data[66]  <= 32'hffffffff;
data[67]  <= 32'hffffffff;
data[68]  <= 32'hffffffff;
data[69]  <= 32'hffffffff;
data[70]  <= 32'hffffffff;
data[71]  <= 32'hffffffff;
data[72]  <= 32'hffffffff;
data[73]  <= 32'hffffffff;
data[74]  <= 32'hffffffff;
data[75]  <= 32'hffffffff;
data[76]  <= 32'hffffffff;
data[77]  <= 32'hffffffff;
data[78]  <= 32'hffffffff;
data[79]  <= 32'hffffffff;
data[80]  <= 32'hffffffff;
data[81]  <= 32'hffffffff;
data[82]  <= 32'hffffffff;
data[83]  <= 32'hffffffff;
data[84]  <= 32'hffffffff;
data[85]  <= 32'hffffffff;
data[86]  <= 32'hffffffff;
data[87]  <= 32'hffffffff;
data[88]  <= 32'hffffffff;
data[89]  <= 32'hffffffff;
data[90]  <= 32'hffffffff;
data[91]  <= 32'hffffffff;
data[92]  <= 32'hffffffff;
data[93]  <= 32'hffffffff;
data[94]  <= 32'hffffffff;
data[95]  <= 32'hffffffff;
data[96]  <= 32'hffffffff;
data[97]  <= 32'hffffffff;
data[98]  <= 32'hffffffff;
data[99]  <= 32'hffffffff;
data[100]  <= 32'hffffffff;
data[101]  <= 32'hffffffff;
data[102]  <= 32'hffffffff;
data[103]  <= 32'hffffffff;
data[104]  <= 32'hffffffff;
data[105]  <= 32'hffffffff;
data[106]  <= 32'hffffffff;
data[107]  <= 32'hffffffff;
data[108]  <= 32'hffffffff;
data[109]  <= 32'hffffffff;
data[110]  <= 32'hffffffff;
data[111]  <= 32'hffffffff;
data[112]  <= 32'hffffffff;
data[113]  <= 32'hffffffff;
data[114]  <= 32'hffffffff;
data[115]  <= 32'hffffffff;
data[116]  <= 32'hffffffff;
data[117]  <= 32'hffffffff;
data[118]  <= 32'hffffffff;
data[119]  <= 32'hffffffff;
data[120]  <= 32'hffffffff;
data[121]  <= 32'hffffffff;
data[122]  <= 32'hffffffff;
data[123]  <= 32'hffffffff;
data[124]  <= 32'hffffffff;
data[125]  <= 32'hffffffff;
data[126]  <= 32'hffffffff;
data[127]  <= 32'hffffffff;
data[128]  <= 32'hffffffff;
data[129]  <= 32'hffffffff;
data[130]  <= 32'hffffffff;
data[131]  <= 32'hffffffff;
data[132]  <= 32'hffffffff;
data[133]  <= 32'hffffffff;
data[134]  <= 32'hffffffff;
data[135]  <= 32'hffffffff;
data[136]  <= 32'hffffffff;
data[137]  <= 32'hffffffff;
data[138]  <= 32'hffffffff;
data[139]  <= 32'hffffffff;
data[140]  <= 32'hffffffff;
data[141]  <= 32'hffffffff;
data[142]  <= 32'hffffffff;
data[143]  <= 32'hffffffff;
data[144]  <= 32'hffffffff;
data[145]  <= 32'hffffffff;
data[146]  <= 32'hffffffff;
data[147]  <= 32'hffffffff;
data[148]  <= 32'hffffffff;
data[149]  <= 32'hffffffff;
data[150]  <= 32'hffffffff;
data[151]  <= 32'hffffffff;
data[152]  <= 32'hffffffff;
data[153]  <= 32'hffffffff;
data[154]  <= 32'hffffffff;
data[155]  <= 32'hffffffff;
data[156]  <= 32'hffffffff;
data[157]  <= 32'hffffffff;
data[158]  <= 32'hffffffff;
data[159]  <= 32'hffffffff;
data[160]  <= 32'hffffffff;
data[161]  <= 32'hffffffff;
data[162]  <= 32'hffffffff;
data[163]  <= 32'hffffffff;
data[164]  <= 32'hffffffff;
data[165]  <= 32'hffffffff;
data[166]  <= 32'hffffffff;
data[167]  <= 32'hffffffff;
data[168]  <= 32'hffffffff;
data[169]  <= 32'hffffffff;
data[170]  <= 32'hffffffff;
data[171]  <= 32'hffffffff;
data[172]  <= 32'hffffffff;
data[173]  <= 32'hffffffff;
data[174]  <= 32'hffffffff;
data[175]  <= 32'hffffffff;
data[176]  <= 32'hffffffff;
data[177]  <= 32'hffffffff;
data[178]  <= 32'hffffffff;
data[179]  <= 32'hffffffff;
data[180]  <= 32'hffffffff;
data[181]  <= 32'hffffffff;
data[182]  <= 32'hffffffff;
data[183]  <= 32'hffffffff;
data[184]  <= 32'hffffffff;
data[185]  <= 32'hffffffff;
data[186]  <= 32'hffffffff;
data[187]  <= 32'hffffffff;
data[188]  <= 32'hffffffff;
data[189]  <= 32'hffffffff;
data[190]  <= 32'hffffffff;
data[191]  <= 32'hffffffff;
data[192]  <= 32'hffffffff;
data[193]  <= 32'hffffffff;
data[194]  <= 32'hffffffff;
data[195]  <= 32'hffffffff;
data[196]  <= 32'hffffffff;
data[197]  <= 32'hffffffff;
data[198]  <= 32'hffffffff;
data[199]  <= 32'hffffffff;
data[200]  <= 32'hffffffff;
data[201]  <= 32'hffffffff;
data[202]  <= 32'hffffffff;
data[203]  <= 32'hffffffff;
data[204]  <= 32'hffffffff;
data[205]  <= 32'hffffffff;
data[206]  <= 32'hffffffff;
data[207]  <= 32'hffffffff;
data[208]  <= 32'hffffffff;
data[209]  <= 32'hffffffff;
data[210]  <= 32'hffffffff;
data[211]  <= 32'hffffffff;
data[212]  <= 32'hffffffff;
data[213]  <= 32'hffffffff;
data[214]  <= 32'hffffffff;
data[215]  <= 32'hffffffff;
data[216]  <= 32'hffffffff;
data[217]  <= 32'hffffffff;
data[218]  <= 32'hffffffff;
data[219]  <= 32'hffffffff;
data[220]  <= 32'hffffffff;
data[221]  <= 32'hffffffff;
data[222]  <= 32'hffffffff;
data[223]  <= 32'hffffffff;
data[224]  <= 32'hffffffff;
data[225]  <= 32'hffffffff;
data[226]  <= 32'hffffffff;
data[227]  <= 32'hffffffff;
data[228]  <= 32'hffffffff;
data[229]  <= 32'hffffffff;
data[230]  <= 32'hffffffff;
data[231]  <= 32'hffffffff;
data[232]  <= 32'hffffffff;
data[233]  <= 32'hffffffff;
data[234]  <= 32'hffffffff;
data[235]  <= 32'hffffffff;
data[236]  <= 32'hffffffff;
data[237]  <= 32'hffffffff;
data[238]  <= 32'hffffffff;
data[239]  <= 32'hffffffff;
data[240]  <= 32'hffffffff;
data[241]  <= 32'hffffffff;
data[242]  <= 32'hffffffff;
data[243]  <= 32'hffffffff;
data[244]  <= 32'hffffffff;
data[245]  <= 32'hffffffff;
data[246]  <= 32'hffffffff;
data[247]  <= 32'hffffffff;
data[248]  <= 32'hffffffff;
data[249]  <= 32'hffffffff;
data[250]  <= 32'hffffffff;
data[251]  <= 32'hffffffff;
data[252]  <= 32'hffffffff;
data[253]  <= 32'hffffffff;
data[254]  <= 32'hffffffff;
data[255]  <= 32'hffffffff;

        p_x <= 4'b0000;
        p_y <= 4'b0000;
        player_x <= 32'h000000f0;
    end
end

/* --- VGA Driver --- */


            
            
// safsadf
//always @(posedge clk_vga)begin
//    if(control[0]==1)begin
//        data[addr_s]<=data_in;
//    end
//end

//  initial begin
//$readmemh("C:/Users/ASUS/Desktop/wksp/cpu/vga_demo/testcode/data.mem", data,0,255);
//end

/* RGB signals */
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

always @(negedge clk_vga)begin
    p_x<=(h_count-500)/40;
    p_y<=(v_count-100)/40;
//    player_x<=data[{p_x,p_y}];
    player_x<=32'hffffffff;
end

/* --- Control RGB --- */

reg[1:0] debug;

always @ (posedge clk_vga) begin
    /* Game board */
    if (h_count < 1140 && h_count > 500 && v_count < 740 && v_count > 100) begin
        if (h_count < 540 && h_count > 500 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b1001;
reg_green   <=4'b0001;
reg_blue   <=4'b1001;
end
else if (h_count < 580 && h_count > 540 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b0110;
reg_green   <=4'b0011;
reg_blue   <=4'b1000;
end
else if (h_count < 620 && h_count > 580 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b0100;
reg_green   <=4'b1111;
reg_blue   <=4'b1001;
end
else if (h_count < 660 && h_count > 620 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b1111;
reg_green   <=4'b1100;
reg_blue   <=4'b1000;
end
else if (h_count < 700 && h_count > 660 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b0011;
reg_green   <=4'b0110;
reg_blue   <=4'b0001;
end
else if (h_count < 740 && h_count > 700 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b1001;
reg_green   <=4'b0101;
reg_blue   <=4'b0000;
end
else if (h_count < 780 && h_count > 740 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b1010;
reg_green   <=4'b0111;
reg_blue   <=4'b0001;
end
else if (h_count < 820 && h_count > 780 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b0100;
reg_green   <=4'b1000;
reg_blue   <=4'b0000;
end
else if (h_count < 860 && h_count > 820 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b1111;
reg_green   <=4'b1010;
reg_blue   <=4'b0001;
end
else if (h_count < 900 && h_count > 860 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b1101;
reg_green   <=4'b0001;
reg_blue   <=4'b0000;
end
else if (h_count < 940 && h_count > 900 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b0001;
reg_green   <=4'b0011;
reg_blue   <=4'b1110;
end
else if (h_count < 980 && h_count > 940 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b1010;
reg_green   <=4'b1111;
reg_blue   <=4'b1111;
end
else if (h_count < 1020 && h_count > 980 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b0100;
reg_green   <=4'b1100;
reg_blue   <=4'b1110;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b0111;
reg_green   <=4'b1110;
reg_blue   <=4'b1111;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b1101;
reg_green   <=4'b0101;
reg_blue   <=4'b1110;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 140 && v_count > 100) begin
reg_red   <=4'b0001;
reg_green   <=4'b0111;
reg_blue   <=4'b1111;
end
else if (h_count < 540 && h_count > 500 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b1010;
reg_green   <=4'b1000;
reg_blue   <=4'b0110;
end
else if (h_count < 580 && h_count > 540 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b1000;
reg_green   <=4'b1010;
reg_blue   <=4'b0111;
end
else if (h_count < 620 && h_count > 580 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b0111;
reg_green   <=4'b1001;
reg_blue   <=4'b0110;
end
else if (h_count < 660 && h_count > 620 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b1101;
reg_green   <=4'b0011;
reg_blue   <=4'b0111;
end
else if (h_count < 700 && h_count > 660 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b0001;
reg_green   <=4'b0000;
reg_blue   <=4'b0110;
end
else if (h_count < 740 && h_count > 700 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b0010;
reg_green   <=4'b1100;
reg_blue   <=4'b0111;
end
else if (h_count < 780 && h_count > 740 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b1000;
reg_green   <=4'b1110;
reg_blue   <=4'b1010;
end
else if (h_count < 820 && h_count > 780 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b0111;
reg_green   <=4'b1101;
reg_blue   <=4'b1011;
end
else if (h_count < 860 && h_count > 820 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b1101;
reg_green   <=4'b0111;
reg_blue   <=4'b1010;
end
else if (h_count < 900 && h_count > 860 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b1110;
reg_green   <=4'b0100;
reg_blue   <=4'b1011;
end
else if (h_count < 940 && h_count > 900 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b0010;
reg_green   <=4'b1010;
reg_blue   <=4'b1010;
end
else if (h_count < 980 && h_count > 940 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b1000;
reg_green   <=4'b1001;
reg_blue   <=4'b1011;
end
else if (h_count < 1020 && h_count > 980 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b1011;
reg_green   <=4'b1011;
reg_blue   <=4'b0010;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b0101;
reg_green   <=4'b0000;
reg_blue   <=4'b0011;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b1110;
reg_green   <=4'b0010;
reg_blue   <=4'b0010;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 180 && v_count > 140) begin
reg_red   <=4'b0010;
reg_green   <=4'b1110;
reg_blue   <=4'b0011;
end
else if (h_count < 540 && h_count > 500 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b0000;
reg_green   <=4'b1101;
reg_blue   <=4'b0010;
end
else if (h_count < 580 && h_count > 540 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b1011;
reg_green   <=4'b1111;
reg_blue   <=4'b1101;
end
else if (h_count < 620 && h_count > 580 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b0101;
reg_green   <=4'b0100;
reg_blue   <=4'b1100;
end
else if (h_count < 660 && h_count > 620 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b1110;
reg_green   <=4'b0110;
reg_blue   <=4'b1101;
end
else if (h_count < 700 && h_count > 660 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b1100;
reg_green   <=4'b1001;
reg_blue   <=4'b1100;
end
else if (h_count < 740 && h_count > 700 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b0000;
reg_green   <=4'b1011;
reg_blue   <=4'b1101;
end
else if (h_count < 780 && h_count > 740 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b1011;
reg_green   <=4'b1000;
reg_blue   <=4'b1100;
end
else if (h_count < 820 && h_count > 780 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b0101;
reg_green   <=4'b0010;
reg_blue   <=4'b0101;
end
else if (h_count < 860 && h_count > 820 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b0110;
reg_green   <=4'b0001;
reg_blue   <=4'b0100;
end
else if (h_count < 900 && h_count > 860 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b1100;
reg_green   <=4'b1101;
reg_blue   <=4'b0101;
end
else if (h_count < 940 && h_count > 900 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b0000;
reg_green   <=4'b1111;
reg_blue   <=4'b0100;
end
else if (h_count < 980 && h_count > 940 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b0011;
reg_green   <=4'b0100;
reg_blue   <=4'b0101;
end
else if (h_count < 1020 && h_count > 980 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b1001;
reg_green   <=4'b0110;
reg_blue   <=4'b0100;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b0110;
reg_green   <=4'b0101;
reg_blue   <=4'b1001;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b1100;
reg_green   <=4'b1011;
reg_blue   <=4'b1000;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 220 && v_count > 180) begin
reg_red   <=4'b1111;
reg_green   <=4'b1000;
reg_blue   <=4'b1001;
end
else if (h_count < 540 && h_count > 500 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b0011;
reg_green   <=4'b0010;
reg_blue   <=4'b1000;
end
else if (h_count < 580 && h_count > 540 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b1001;
reg_green   <=4'b0001;
reg_blue   <=4'b1001;
end
else if (h_count < 620 && h_count > 580 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b0110;
reg_green   <=4'b0011;
reg_blue   <=4'b1000;
end
else if (h_count < 660 && h_count > 620 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b0100;
reg_green   <=4'b1111;
reg_blue   <=4'b0001;
end
else if (h_count < 700 && h_count > 660 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b1111;
reg_green   <=4'b1100;
reg_blue   <=4'b0000;
end
else if (h_count < 740 && h_count > 700 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b0011;
reg_green   <=4'b0110;
reg_blue   <=4'b0001;
end
else if (h_count < 780 && h_count > 740 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b1001;
reg_green   <=4'b0101;
reg_blue   <=4'b0000;
end
else if (h_count < 820 && h_count > 780 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b1010;
reg_green   <=4'b0111;
reg_blue   <=4'b0001;
end
else if (h_count < 860 && h_count > 820 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b0100;
reg_green   <=4'b1000;
reg_blue   <=4'b0000;
end
else if (h_count < 900 && h_count > 860 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b1111;
reg_green   <=4'b1010;
reg_blue   <=4'b1110;
end
else if (h_count < 940 && h_count > 900 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b1101;
reg_green   <=4'b0001;
reg_blue   <=4'b1111;
end
else if (h_count < 980 && h_count > 940 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b0001;
reg_green   <=4'b0011;
reg_blue   <=4'b1110;
end
else if (h_count < 1020 && h_count > 980 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b1010;
reg_green   <=4'b0000;
reg_blue   <=4'b1111;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b0100;
reg_green   <=4'b1100;
reg_blue   <=4'b1110;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b0111;
reg_green   <=4'b1110;
reg_blue   <=4'b1111;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 260 && v_count > 220) begin
reg_red   <=4'b1101;
reg_green   <=4'b0101;
reg_blue   <=4'b0110;
end
else if (h_count < 540 && h_count > 500 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b0001;
reg_green   <=4'b0111;
reg_blue   <=4'b0111;
end
else if (h_count < 580 && h_count > 540 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b1010;
reg_green   <=4'b0100;
reg_blue   <=4'b0110;
end
else if (h_count < 620 && h_count > 580 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b1000;
reg_green   <=4'b1010;
reg_blue   <=4'b0111;
end
else if (h_count < 660 && h_count > 620 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b0111;
reg_green   <=4'b1001;
reg_blue   <=4'b0110;
end
else if (h_count < 700 && h_count > 660 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b1101;
reg_green   <=4'b0011;
reg_blue   <=4'b1011;
end
else if (h_count < 740 && h_count > 700 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b0001;
reg_green   <=4'b0000;
reg_blue   <=4'b1010;
end
else if (h_count < 780 && h_count > 740 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b0010;
reg_green   <=4'b1100;
reg_blue   <=4'b1011;
end
else if (h_count < 820 && h_count > 780 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b1000;
reg_green   <=4'b1110;
reg_blue   <=4'b1010;
end
else if (h_count < 860 && h_count > 820 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b0111;
reg_green   <=4'b1101;
reg_blue   <=4'b1011;
end
else if (h_count < 900 && h_count > 860 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b0101;
reg_green   <=4'b0111;
reg_blue   <=4'b1010;
end
else if (h_count < 940 && h_count > 900 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b1110;
reg_green   <=4'b0100;
reg_blue   <=4'b0011;
end
else if (h_count < 980 && h_count > 940 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b0010;
reg_green   <=4'b1010;
reg_blue   <=4'b0010;
end
else if (h_count < 1020 && h_count > 980 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b1000;
reg_green   <=4'b1001;
reg_blue   <=4'b0011;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b1011;
reg_green   <=4'b1011;
reg_blue   <=4'b0010;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b0101;
reg_green   <=4'b0000;
reg_blue   <=4'b0011;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 300 && v_count > 260) begin
reg_red   <=4'b1110;
reg_green   <=4'b0010;
reg_blue   <=4'b0010;
end
else if (h_count < 540 && h_count > 500 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b0010;
reg_green   <=4'b1110;
reg_blue   <=4'b1101;
end
else if (h_count < 580 && h_count > 540 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b0000;
reg_green   <=4'b1101;
reg_blue   <=4'b1100;
end
else if (h_count < 620 && h_count > 580 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b1011;
reg_green   <=4'b1111;
reg_blue   <=4'b1101;
end
else if (h_count < 660 && h_count > 620 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b0101;
reg_green   <=4'b0100;
reg_blue   <=4'b1100;
end
else if (h_count < 700 && h_count > 660 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b1110;
reg_green   <=4'b0110;
reg_blue   <=4'b1101;
end
else if (h_count < 740 && h_count > 700 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b1100;
reg_green   <=4'b1001;
reg_blue   <=4'b1100;
end
else if (h_count < 780 && h_count > 740 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b0000;
reg_green   <=4'b1011;
reg_blue   <=4'b0101;
end
else if (h_count < 820 && h_count > 780 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b1011;
reg_green   <=4'b1000;
reg_blue   <=4'b0100;
end
else if (h_count < 860 && h_count > 820 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b0101;
reg_green   <=4'b0010;
reg_blue   <=4'b0101;
end
else if (h_count < 900 && h_count > 860 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b0110;
reg_green   <=4'b0001;
reg_blue   <=4'b0100;
end
else if (h_count < 940 && h_count > 900 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b1100;
reg_green   <=4'b1101;
reg_blue   <=4'b0101;
end
else if (h_count < 980 && h_count > 940 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b0000;
reg_green   <=4'b1111;
reg_blue   <=4'b0100;
end
else if (h_count < 1020 && h_count > 980 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b0011;
reg_green   <=4'b1100;
reg_blue   <=4'b1001;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b1001;
reg_green   <=4'b0110;
reg_blue   <=4'b1000;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b0110;
reg_green   <=4'b0101;
reg_blue   <=4'b1001;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 340 && v_count > 300) begin
reg_red   <=4'b1100;
reg_green   <=4'b1011;
reg_blue   <=4'b1000;
end
else if (h_count < 540 && h_count > 500 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b1111;
reg_green   <=4'b1000;
reg_blue   <=4'b1001;
end
else if (h_count < 580 && h_count > 540 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b0011;
reg_green   <=4'b1010;
reg_blue   <=4'b1000;
end
else if (h_count < 620 && h_count > 580 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b1001;
reg_green   <=4'b0001;
reg_blue   <=4'b0001;
end
else if (h_count < 660 && h_count > 620 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b0110;
reg_green   <=4'b0011;
reg_blue   <=4'b0000;
end
else if (h_count < 700 && h_count > 660 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b0100;
reg_green   <=4'b1111;
reg_blue   <=4'b0001;
end
else if (h_count < 740 && h_count > 700 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b1111;
reg_green   <=4'b1100;
reg_blue   <=4'b0000;
end
else if (h_count < 780 && h_count > 740 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b0011;
reg_green   <=4'b0110;
reg_blue   <=4'b0001;
end
else if (h_count < 820 && h_count > 780 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b1001;
reg_green   <=4'b0101;
reg_blue   <=4'b1111;
end
else if (h_count < 860 && h_count > 820 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b1010;
reg_green   <=4'b0111;
reg_blue   <=4'b1110;
end
else if (h_count < 900 && h_count > 860 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b0100;
reg_green   <=4'b1000;
reg_blue   <=4'b1111;
end
else if (h_count < 940 && h_count > 900 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b1111;
reg_green   <=4'b1010;
reg_blue   <=4'b1110;
end
else if (h_count < 980 && h_count > 940 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b1101;
reg_green   <=4'b0001;
reg_blue   <=4'b1111;
end
else if (h_count < 1020 && h_count > 980 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b0001;
reg_green   <=4'b0011;
reg_blue   <=4'b1110;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b1010;
reg_green   <=4'b0000;
reg_blue   <=4'b0111;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b0100;
reg_green   <=4'b1100;
reg_blue   <=4'b0110;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 380 && v_count > 340) begin
reg_red   <=4'b0111;
reg_green   <=4'b1110;
reg_blue   <=4'b0111;
end
else if (h_count < 540 && h_count > 500 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b1101;
reg_green   <=4'b0101;
reg_blue   <=4'b0110;
end
else if (h_count < 580 && h_count > 540 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b0001;
reg_green   <=4'b0111;
reg_blue   <=4'b0111;
end
else if (h_count < 620 && h_count > 580 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b1010;
reg_green   <=4'b0100;
reg_blue   <=4'b0110;
end
else if (h_count < 660 && h_count > 620 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b1000;
reg_green   <=4'b1010;
reg_blue   <=4'b1011;
end
else if (h_count < 700 && h_count > 660 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b0111;
reg_green   <=4'b1001;
reg_blue   <=4'b1010;
end
else if (h_count < 740 && h_count > 700 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b1101;
reg_green   <=4'b0011;
reg_blue   <=4'b1011;
end
else if (h_count < 780 && h_count > 740 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b0001;
reg_green   <=4'b0000;
reg_blue   <=4'b1010;
end
else if (h_count < 820 && h_count > 780 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b0010;
reg_green   <=4'b0010;
reg_blue   <=4'b1011;
end
else if (h_count < 860 && h_count > 820 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b1000;
reg_green   <=4'b1110;
reg_blue   <=4'b1010;
end
else if (h_count < 900 && h_count > 860 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b0111;
reg_green   <=4'b1101;
reg_blue   <=4'b0011;
end
else if (h_count < 940 && h_count > 900 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b0101;
reg_green   <=4'b0111;
reg_blue   <=4'b0010;
end
else if (h_count < 980 && h_count > 940 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b1110;
reg_green   <=4'b0100;
reg_blue   <=4'b0011;
end
else if (h_count < 1020 && h_count > 980 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b0010;
reg_green   <=4'b0110;
reg_blue   <=4'b0010;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b1000;
reg_green   <=4'b1001;
reg_blue   <=4'b0011;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b1011;
reg_green   <=4'b1011;
reg_blue   <=4'b0010;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 420 && v_count > 380) begin
reg_red   <=4'b0101;
reg_green   <=4'b0000;
reg_blue   <=4'b1101;
end
else if (h_count < 540 && h_count > 500 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b1110;
reg_green   <=4'b0010;
reg_blue   <=4'b1100;
end
else if (h_count < 580 && h_count > 540 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b0010;
reg_green   <=4'b0001;
reg_blue   <=4'b1101;
end
else if (h_count < 620 && h_count > 580 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b0000;
reg_green   <=4'b1101;
reg_blue   <=4'b1100;
end
else if (h_count < 660 && h_count > 620 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b1011;
reg_green   <=4'b1111;
reg_blue   <=4'b1101;
end
else if (h_count < 700 && h_count > 660 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b0101;
reg_green   <=4'b0100;
reg_blue   <=4'b1100;
end
else if (h_count < 740 && h_count > 700 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b1110;
reg_green   <=4'b0110;
reg_blue   <=4'b0101;
end
else if (h_count < 780 && h_count > 740 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b1100;
reg_green   <=4'b1001;
reg_blue   <=4'b0100;
end
else if (h_count < 820 && h_count > 780 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b0000;
reg_green   <=4'b1011;
reg_blue   <=4'b0101;
end
else if (h_count < 860 && h_count > 820 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b1011;
reg_green   <=4'b1000;
reg_blue   <=4'b0100;
end
else if (h_count < 900 && h_count > 860 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b1001;
reg_green   <=4'b0010;
reg_blue   <=4'b0101;
end
else if (h_count < 940 && h_count > 900 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b0110;
reg_green   <=4'b0001;
reg_blue   <=4'b1000;
end
else if (h_count < 980 && h_count > 940 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b1100;
reg_green   <=4'b1101;
reg_blue   <=4'b1001;
end
else if (h_count < 1020 && h_count > 980 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b0000;
reg_green   <=4'b1111;
reg_blue   <=4'b1000;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b0011;
reg_green   <=4'b1100;
reg_blue   <=4'b1001;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b1001;
reg_green   <=4'b0110;
reg_blue   <=4'b1000;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 460 && v_count > 420) begin
reg_red   <=4'b0110;
reg_green   <=4'b0101;
reg_blue   <=4'b1001;
end
else if (h_count < 540 && h_count > 500 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b1100;
reg_green   <=4'b1011;
reg_blue   <=4'b0000;
end
else if (h_count < 580 && h_count > 540 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b1111;
reg_green   <=4'b1000;
reg_blue   <=4'b0001;
end
else if (h_count < 620 && h_count > 580 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b0011;
reg_green   <=4'b1010;
reg_blue   <=4'b0000;
end
else if (h_count < 660 && h_count > 620 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b1001;
reg_green   <=4'b0001;
reg_blue   <=4'b0001;
end
else if (h_count < 700 && h_count > 660 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b0110;
reg_green   <=4'b0011;
reg_blue   <=4'b0000;
end
else if (h_count < 740 && h_count > 700 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b0100;
reg_green   <=4'b1111;
reg_blue   <=4'b0001;
end
else if (h_count < 780 && h_count > 740 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b1111;
reg_green   <=4'b1100;
reg_blue   <=4'b1111;
end
else if (h_count < 820 && h_count > 780 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b0011;
reg_green   <=4'b1110;
reg_blue   <=4'b1110;
end
else if (h_count < 860 && h_count > 820 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b1001;
reg_green   <=4'b0101;
reg_blue   <=4'b1111;
end
else if (h_count < 900 && h_count > 860 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b1010;
reg_green   <=4'b0111;
reg_blue   <=4'b1110;
end
else if (h_count < 940 && h_count > 900 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b0100;
reg_green   <=4'b1000;
reg_blue   <=4'b1111;
end
else if (h_count < 980 && h_count > 940 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b1111;
reg_green   <=4'b1010;
reg_blue   <=4'b1110;
end
else if (h_count < 1020 && h_count > 980 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b1101;
reg_green   <=4'b1001;
reg_blue   <=4'b0111;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b0001;
reg_green   <=4'b0011;
reg_blue   <=4'b0110;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b1010;
reg_green   <=4'b0000;
reg_blue   <=4'b0111;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 500 && v_count > 460) begin
reg_red   <=4'b0100;
reg_green   <=4'b1100;
reg_blue   <=4'b0110;
end
else if (h_count < 540 && h_count > 500 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b0111;
reg_green   <=4'b1110;
reg_blue   <=4'b0111;
end
else if (h_count < 580 && h_count > 540 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b1101;
reg_green   <=4'b1101;
reg_blue   <=4'b0110;
end
else if (h_count < 620 && h_count > 580 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b0001;
reg_green   <=4'b0111;
reg_blue   <=4'b1011;
end
else if (h_count < 660 && h_count > 620 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b1010;
reg_green   <=4'b0100;
reg_blue   <=4'b1010;
end
else if (h_count < 700 && h_count > 660 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b1000;
reg_green   <=4'b1010;
reg_blue   <=4'b1011;
end
else if (h_count < 740 && h_count > 700 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b0111;
reg_green   <=4'b1001;
reg_blue   <=4'b1010;
end
else if (h_count < 780 && h_count > 740 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b1101;
reg_green   <=4'b0011;
reg_blue   <=4'b1011;
end
else if (h_count < 820 && h_count > 780 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b0001;
reg_green   <=4'b0000;
reg_blue   <=4'b1010;
end
else if (h_count < 860 && h_count > 820 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b0010;
reg_green   <=4'b0010;
reg_blue   <=4'b0011;
end
else if (h_count < 900 && h_count > 860 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b1000;
reg_green   <=4'b1110;
reg_blue   <=4'b0010;
end
else if (h_count < 940 && h_count > 900 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b0111;
reg_green   <=4'b1101;
reg_blue   <=4'b0011;
end
else if (h_count < 980 && h_count > 940 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b0101;
reg_green   <=4'b0111;
reg_blue   <=4'b0010;
end
else if (h_count < 1020 && h_count > 980 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b1110;
reg_green   <=4'b0100;
reg_blue   <=4'b0011;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b0010;
reg_green   <=4'b0110;
reg_blue   <=4'b1100;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b1000;
reg_green   <=4'b1001;
reg_blue   <=4'b1101;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 540 && v_count > 500) begin
reg_red   <=4'b1011;
reg_green   <=4'b1011;
reg_blue   <=4'b1100;
end
else if (h_count < 540 && h_count > 500 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b0101;
reg_green   <=4'b0000;
reg_blue   <=4'b1101;
end
else if (h_count < 580 && h_count > 540 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b1110;
reg_green   <=4'b0010;
reg_blue   <=4'b1100;
end
else if (h_count < 620 && h_count > 580 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b0010;
reg_green   <=4'b0001;
reg_blue   <=4'b1101;
end
else if (h_count < 660 && h_count > 620 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b0000;
reg_green   <=4'b1101;
reg_blue   <=4'b0100;
end
else if (h_count < 700 && h_count > 660 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b1011;
reg_green   <=4'b1111;
reg_blue   <=4'b0101;
end
else if (h_count < 740 && h_count > 700 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b0101;
reg_green   <=4'b0100;
reg_blue   <=4'b0100;
end
else if (h_count < 780 && h_count > 740 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b1110;
reg_green   <=4'b0110;
reg_blue   <=4'b0101;
end
else if (h_count < 820 && h_count > 780 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b1100;
reg_green   <=4'b0101;
reg_blue   <=4'b0100;
end
else if (h_count < 860 && h_count > 820 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b0000;
reg_green   <=4'b1011;
reg_blue   <=4'b0101;
end
else if (h_count < 900 && h_count > 860 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b1011;
reg_green   <=4'b1000;
reg_blue   <=4'b1000;
end
else if (h_count < 940 && h_count > 900 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b1001;
reg_green   <=4'b0010;
reg_blue   <=4'b1001;
end
else if (h_count < 980 && h_count > 940 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b0110;
reg_green   <=4'b0001;
reg_blue   <=4'b1000;
end
else if (h_count < 1020 && h_count > 980 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b1100;
reg_green   <=4'b0011;
reg_blue   <=4'b1001;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b0000;
reg_green   <=4'b1111;
reg_blue   <=4'b1000;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b0011;
reg_green   <=4'b1100;
reg_blue   <=4'b1001;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 580 && v_count > 540) begin
reg_red   <=4'b1001;
reg_green   <=4'b0110;
reg_blue   <=4'b0000;
end
else if (h_count < 540 && h_count > 500 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b0110;
reg_green   <=4'b0101;
reg_blue   <=4'b0001;
end
else if (h_count < 580 && h_count > 540 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b1100;
reg_green   <=4'b0111;
reg_blue   <=4'b0000;
end
else if (h_count < 620 && h_count > 580 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b1111;
reg_green   <=4'b1000;
reg_blue   <=4'b0001;
end
else if (h_count < 660 && h_count > 620 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b0011;
reg_green   <=4'b1010;
reg_blue   <=4'b0000;
end
else if (h_count < 700 && h_count > 660 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b1001;
reg_green   <=4'b0001;
reg_blue   <=4'b0001;
end
else if (h_count < 740 && h_count > 700 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b0110;
reg_green   <=4'b0011;
reg_blue   <=4'b1111;
end
else if (h_count < 780 && h_count > 740 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b0100;
reg_green   <=4'b1111;
reg_blue   <=4'b1110;
end
else if (h_count < 820 && h_count > 780 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b1111;
reg_green   <=4'b1100;
reg_blue   <=4'b1111;
end
else if (h_count < 860 && h_count > 820 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b0011;
reg_green   <=4'b1110;
reg_blue   <=4'b1110;
end
else if (h_count < 900 && h_count > 860 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b0001;
reg_green   <=4'b0101;
reg_blue   <=4'b1111;
end
else if (h_count < 940 && h_count > 900 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b1010;
reg_green   <=4'b0111;
reg_blue   <=4'b1110;
end
else if (h_count < 980 && h_count > 940 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b0100;
reg_green   <=4'b1000;
reg_blue   <=4'b0111;
end
else if (h_count < 1020 && h_count > 980 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b1111;
reg_green   <=4'b1010;
reg_blue   <=4'b0110;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b1101;
reg_green   <=4'b1001;
reg_blue   <=4'b0111;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b0001;
reg_green   <=4'b0011;
reg_blue   <=4'b0110;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 620 && v_count > 580) begin
reg_red   <=4'b1010;
reg_green   <=4'b0000;
reg_blue   <=4'b0111;
end
else if (h_count < 540 && h_count > 500 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b0100;
reg_green   <=4'b1100;
reg_blue   <=4'b1010;
end
else if (h_count < 580 && h_count > 540 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b0111;
reg_green   <=4'b1110;
reg_blue   <=4'b1011;
end
else if (h_count < 620 && h_count > 580 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b1101;
reg_green   <=4'b1101;
reg_blue   <=4'b1010;
end
else if (h_count < 660 && h_count > 620 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b0001;
reg_green   <=4'b0111;
reg_blue   <=4'b1011;
end
else if (h_count < 700 && h_count > 660 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b1010;
reg_green   <=4'b0100;
reg_blue   <=4'b1010;
end
else if (h_count < 740 && h_count > 700 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b1000;
reg_green   <=4'b1010;
reg_blue   <=4'b1011;
end
else if (h_count < 780 && h_count > 740 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b0111;
reg_green   <=4'b1001;
reg_blue   <=4'b0010;
end
else if (h_count < 820 && h_count > 780 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b1101;
reg_green   <=4'b1011;
reg_blue   <=4'b0011;
end
else if (h_count < 860 && h_count > 820 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b0001;
reg_green   <=4'b0000;
reg_blue   <=4'b0010;
end
else if (h_count < 900 && h_count > 860 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b0010;
reg_green   <=4'b0010;
reg_blue   <=4'b0011;
end
else if (h_count < 940 && h_count > 900 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b1000;
reg_green   <=4'b1110;
reg_blue   <=4'b0010;
end
else if (h_count < 980 && h_count > 940 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b0111;
reg_green   <=4'b1101;
reg_blue   <=4'b0011;
end
else if (h_count < 1020 && h_count > 980 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b0101;
reg_green   <=4'b1111;
reg_blue   <=4'b1100;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b1110;
reg_green   <=4'b0100;
reg_blue   <=4'b1101;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b0010;
reg_green   <=4'b0110;
reg_blue   <=4'b1100;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 660 && v_count > 620) begin
reg_red   <=4'b1000;
reg_green   <=4'b1001;
reg_blue   <=4'b1101;
end
else if (h_count < 540 && h_count > 500 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b1011;
reg_green   <=4'b1011;
reg_blue   <=4'b1100;
end
else if (h_count < 580 && h_count > 540 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b0101;
reg_green   <=4'b1000;
reg_blue   <=4'b1101;
end
else if (h_count < 620 && h_count > 580 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b1110;
reg_green   <=4'b0010;
reg_blue   <=4'b0100;
end
else if (h_count < 660 && h_count > 620 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b0010;
reg_green   <=4'b0001;
reg_blue   <=4'b0101;
end
else if (h_count < 700 && h_count > 660 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b0000;
reg_green   <=4'b1101;
reg_blue   <=4'b0100;
end
else if (h_count < 740 && h_count > 700 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b1011;
reg_green   <=4'b1111;
reg_blue   <=4'b0101;
end
else if (h_count < 780 && h_count > 740 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b0101;
reg_green   <=4'b0100;
reg_blue   <=4'b0100;
end
else if (h_count < 820 && h_count > 780 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b1110;
reg_green   <=4'b0110;
reg_blue   <=4'b0101;
end
else if (h_count < 860 && h_count > 820 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b1100;
reg_green   <=4'b0101;
reg_blue   <=4'b1000;
end
else if (h_count < 900 && h_count > 860 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b0000;
reg_green   <=4'b1011;
reg_blue   <=4'b1001;
end
else if (h_count < 940 && h_count > 900 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b1011;
reg_green   <=4'b1000;
reg_blue   <=4'b1000;
end
else if (h_count < 980 && h_count > 940 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b1001;
reg_green   <=4'b0010;
reg_blue   <=4'b1001;
end
else if (h_count < 1020 && h_count > 980 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b0110;
reg_green   <=4'b0001;
reg_blue   <=4'b1000;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b1100;
reg_green   <=4'b0011;
reg_blue   <=4'b1001;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b0000;
reg_green   <=4'b1111;
reg_blue   <=4'b0000;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 700 && v_count > 660) begin
reg_red   <=4'b0011;
reg_green   <=4'b1100;
reg_blue   <=4'b0001;
end
else if (h_count < 540 && h_count > 500 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b1001;
reg_green   <=4'b0110;
reg_blue   <=4'b0000;
end
else if (h_count < 580 && h_count > 540 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b0110;
reg_green   <=4'b0101;
reg_blue   <=4'b0001;
end
else if (h_count < 620 && h_count > 580 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b1100;
reg_green   <=4'b0111;
reg_blue   <=4'b0000;
end
else if (h_count < 660 && h_count > 620 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b1111;
reg_green   <=4'b1000;
reg_blue   <=4'b1110;
end
else if (h_count < 700 && h_count > 660 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b0011;
reg_green   <=4'b1010;
reg_blue   <=4'b1111;
end
else if (h_count < 740 && h_count > 700 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b1001;
reg_green   <=4'b0001;
reg_blue   <=4'b1110;
end
else if (h_count < 780 && h_count > 740 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b0110;
reg_green   <=4'b0011;
reg_blue   <=4'b1111;
end
else if (h_count < 820 && h_count > 780 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b0100;
reg_green   <=4'b0000;
reg_blue   <=4'b1110;
end
else if (h_count < 860 && h_count > 820 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b1111;
reg_green   <=4'b1100;
reg_blue   <=4'b1111;
end
else if (h_count < 900 && h_count > 860 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b0011;
reg_green   <=4'b1110;
reg_blue   <=4'b0110;
end
else if (h_count < 940 && h_count > 900 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b0001;
reg_green   <=4'b0101;
reg_blue   <=4'b0111;
end
else if (h_count < 980 && h_count > 940 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b1010;
reg_green   <=4'b0111;
reg_blue   <=4'b0110;
end
else if (h_count < 1020 && h_count > 980 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b0100;
reg_green   <=4'b0100;
reg_blue   <=4'b0111;
end
else if (h_count < 1060 && h_count > 1020 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b1111;
reg_green   <=4'b1010;
reg_blue   <=4'b0110;
end
else if (h_count < 1100 && h_count > 1060 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b1101;
reg_green   <=4'b1001;
reg_blue   <=4'b0111;
end
else if (h_count < 1140 && h_count > 1100 && v_count < 740 && v_count > 700) begin
reg_red   <=4'b0001;
reg_green   <=4'b0011;
reg_blue   <=4'b1010;
end

    end

    /* Out of bounds */
    else begin
        reg_red   <= `BLACK_R;
        reg_green <= `BLACK_G;
        reg_blue  <= `BLACK_B;
    end
end
endmodule
