`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2025 01:11:02
// Design Name: 
// Module Name: LFSR_without_counter
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


module LFSR_without_counter
#(parameter N = 18,//1000 1110 0001 1011 00 2's comp of val
localparam seed = 18'h2386C)//decleration of parameter seed which contians the seed hex val 2386C forbidden hex val 3FFFF
(   input clk, sh_en, rst_n,
    output [N-1:0] Q_out,
    output reg max_tick_reg);
    reg [N-1:0] Q_state;
    wire [N-1:0] Q_ns;
    
    always @ (posedge clk, posedge rst_n) begin
        if(rst_n)begin//asynchronous reset
            Q_state <= seed;//resetting to the q state to the seed value
            max_tick_reg <= 1'b0;//resetting max_tick_reg
        end
        else if (sh_en && !rst_n)begin//if reset is low and enable is high then
            Q_state <= Q_ns;//bit shifting occurs
            if(Q_ns == seed)
                max_tick_reg <= 1'b1;
        end
    end
    
//next state logic
    assign Q_fb = Q_state[17] ^~ Q_state[10];//calculation of new bit input
    assign Q_ns = {Q_state[N-2:0],Q_fb};//generating new reg
//output logic
    assign Q_out = Q_state;//the output is assigned to the q_state
endmodule
