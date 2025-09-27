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


module counter_test;
    reg clk, enable, re_set, msb;//decleration of testbench inputs
    wire [20:0] count_1;//decleration of register output
    
    counter uut (.clk(clk), .rst(re_set), .q_bit(msb), .en(enable),//input values declared
    .code_out(count_1));
    
    initial begin   //initialising clock
        clk = 1'b1;    
        forever begin 
        #5 clk = !clk; //every 5ns, invert
        end
    end
    initial begin
        re_set = 1'b1;//initialising reset to high
        enable = 1'b0;// initialising eneable low
        msb = 1'b0;
        #100//pausing for 10 clock cycles.
        re_set = 1'b0;//reset is then set to low
        #10
        enable = 1'b1;//enable is set to high
        msb = 1'b0;//test if 
        #10
        msb = 1'b1;
        #10
        msb = 1'b0;
        #10
        msb = 1'b1;
        #10
        msb = 1'b0;
        #10
        msb = 1'b1;
        #10;
//tests if sequence repeat
        msb = 1'b0;
        #10
        msb = 1'b1;
        #20//test if it resets properly
        msb = 1'b1;//resets to wt
        #10
        msb = 1'b0;
        #10
        msb = 1'b1;
        #10
        msb = 1'b0;
        #10
        msb = 1'b1;
        #10
        msb = 1'b0;
        #10
        msb = 1'b1;
        #10
        msb = 1'b0;
        #20//test if codeword doesn't fully reset if 2 0's
        msb = 1'b0;
        #10
        msb = 1'b1;
        #10
        msb = 1'b0;
        #10
        msb = 1'b1;
        #10
        msb = 1'b0;
        #10;
        msb = 1'b1;
        #10;
        re_set = 1'b1;
        #10
        $stop;//stops simulation so it doesn't run onto infinity
    end
endmodule
