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
    wire [17:0] Qout, count_0, count_1;//decleration of register output
    wire mx_out;//decleration of max counting bit output
    
    LFSR uut (.clk(clk), .sh_en(enable), .rst_n(re_set), .Q_out(Qout), .max_tick_reg(mx_out), .out_0(count_0), .out_1(count_1));
    
    initial begin   //initialising clock
        clk = 1'b1;    
        forever begin 
        #5 clk = !clk; //every 5ns, invert
        end
    end
    initial begin
        re_set = 1'b1;//initialising reset to high
        enable = 1'b0;// initialising eneable low
        #100//pausing for 10 clock cycles.
        re_set = 1'b0;//reset is then set to low
        #10
        enable = 1'b1;//enable is set to high
        #2621440// pausing for 2^n -1 bit shifts
        enable = 1'b0;// set to low
        re_set = 1'b1;
        #10;
        re_set = 1'b0;//reset is then set to low
        #10
        enable = 1'b1;//enable is set to high
        #2621440;// pausing for 2^n -1 bit shifts
        $stop;//stops simulation so it doesn't run onto infinity
    end
endmodule
