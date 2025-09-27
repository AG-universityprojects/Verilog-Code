`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2025 18:29:52
// Design Name: 
// Module Name: test_bench_FpartC
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


module test_bench_FpartC;
    reg clk, enable, re_set;//decleration of testbench inputs
    wire [20:0] Qout, count_0;//decleration of register output
    wire mx_out;//decleration of max counting bit output
    
    LFSR uut (.clk(clk), .sh_en(enable), .rst_n(re_set), .Q_out(Qout), .max_tick_reg(mx_out), .count_C_word(count_0));
    
    initial begin   //initialising clock
        clk = 1'b1;    
        forever begin 
        #5 clk = !clk; //every 5ns, invert
        end
    end
    initial begin
        re_set = 1'b1;//initialising reset to high
        enable = 1'b1;// initialising eneable high
        #50//pausing for 5 clock cycles.
        enable = 1'b0;// initialising eneable low
        #50//pausing for 5 clock cycles.
        re_set = 1'b0;//reset is then set to low
        #10
        enable = 1'b1;//enable is set to high
        #20971510// pausing for 2^n -1 bit shifts
        enable = 1'b0;// set to low
        re_set = 1'b1;
        #10;
        re_set = 1'b0;//reset is then set to low
        #10
        enable = 1'b1;//enable is set to high
        #20971510// pausing for 2^n -1 bit shifts
        $stop;//stops simulation so it doesn't run onto infinity
    end
endmodule
