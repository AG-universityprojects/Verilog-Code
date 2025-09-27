`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2025 13:59:19
// Design Name: 
// Module Name: tb_hex_to_b
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


module tb_hex_to_dec;
    reg clk, re_set;//decleration of testbench inputs
    reg [20:0] word_count;//decleration of register output
    wire [3:0] d3_out, d2_out, d1_out, d0_out;
    
    stop_watch_if uut (.clk(clk), .clr(re_set),
    .counter(word_count),
    .d3(d3_out), .d2(d2_out), .d1(d1_out), .d0(d0_out)//outputs in decimal
   );
    
    initial begin   //initialising clock
        clk = 1'b1;    
        forever begin 
        #5 clk = !clk; //every 5ns, invert
        end
    end
    initial begin
        re_set = 1'b1;//initialising reset to high
        word_count = 21'd0;//setting initial word count to 0
        #100//wait 10 clock cycles
        re_set = 1'b0;//reset is lowered, checking if d0 incremetns at counter = 0
        #20
        word_count = 21'd1;//begin incrementing counter
        #20
        word_count = 21'd4;//if value increments rapidly, making sure it can keep up
        #50
        re_set = 1'b1;//checking if everything resets
        #10;
        re_set = 1'b0;//reset turned off
        word_count = 21'd1000;//checking if incremeting works properly and all wires work
        #10000
        $stop;//stops simulation so it doesn't run onto infinity
    end
endmodule
