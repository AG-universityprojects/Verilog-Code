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
#(parameter N = 21,// 1000100 seed val
localparam seed = 21'h68)//decleration of parameter seed which contians the seed hex val 68 forbidden hex val 1FFFFF
(   input clk, sh_en, rst_n,//decleration of inputs and outputs
    output [N-1:0] Q_out, count_C_word,
    output reg max_tick_reg);
    reg [N-1:0] Q_state;
    wire [N-1:0] Q_ns;
    // 116 board =        1110100
    // last 2 digits 28 = 0011100
    //xor  =              1101000
    counter unt (.clk(clk), .rst(rst_n), .q_bit(Q_state[20]), .en(sh_en), .code_out(count_C_word));  
    always @ (posedge clk, posedge rst_n) begin//clock synchrnous reset is asynchronous
        if(rst_n)begin//when rst_n is pressed
            Q_state <= seed;//resetting to the q state to the seed value
            max_tick_reg <= 1'b0;//resetting max_tick_reg
        end
        else if (sh_en && !rst_n)begin//check if enable is high and reset is low
            Q_state <= Q_ns;//sets new state of q_state
            if(Q_ns == seed)//checks if the next reg is = to the seed value
                max_tick_reg <= 1'b1;
        end
    end
    
//next state logic
    assign Q_fb = Q_state[20] ^~ Q_state[18];
    assign Q_ns = {Q_state[N-2:0],Q_fb};
//output logic
    assign Q_out = Q_state;
endmodule
