`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2025 00:47:22
// Design Name: 
// Module Name: LFSR
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


module LFSR
#(parameter N = 18,//1000 1110 0001 1011 00 2's comp of val
localparam seed = 18'h2386C)//decleration of parameter seed which contians the seed hex val 2386C forbidden hex val 3FFFF
(   input clk, sh_en, rst_n,//decleration of inputs and outputs
    output [N-1:0] Q_out,out_0, out_1,
    output reg max_tick_reg);
    reg [N-1:0] Q_state;
    wire [N-1:0] Q_ns;
    
    counter unt (.clk(clk), .rst(rst_n), .q_bit(Q_state[17]), .en(sh_en), .max(max_tick_reg), .out_0(out_0), .out_1(out_1));  
    always @ (posedge clk, posedge rst_n) begin//clock synchrnous reset is asynchronous
        if(rst_n)begin//when rst_n is pressed
            Q_state <= seed;//resetting to the q state to the seed value
            max_tick_reg <= 1'b0;//resetting max_tick_reg
        end
        else if (sh_en && !rst_n)begin
            Q_state <= Q_ns;
            if(Q_ns == seed)
                max_tick_reg <= 1'b1;
        end
    end
    
//next state logic
    assign Q_fb = Q_state[17] ^~ Q_state[10];
    assign Q_ns = {Q_state[N-2:0],Q_fb};
//output logic
    assign Q_out = Q_state;
endmodule
