`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 00:49:41
// Design Name: 
// Module Name: tb_top
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


module tb_top;
    reg cclk, reset, reg_check;
    wire max_val;
    wire [3:0] an;
    wire [7:0] seven_seg;
    wire [10:0]lfsr;
    //inistatiating the top module
    top_mod uut (
    .CCLK(cclk), .reset(reset), .reg_check(reg_check),
    .max_tick(max_val), .lfsr_reg(lfsr), .an(an), .sseg(seven_seg)
    );
    
    initial begin   //initialising clock
        cclk = 1'b1;    
        forever begin 
        #1 cclk = !cclk; //every 1ns, invert
        end
    end
    
    initial begin
        reset = 1'b1;//testing rest works properly
        reg_check = 1'b0;//testing led output changing aacording to switch
        #198
        reset = 1'b0;//reset goes low
        #200
        reset = 1'b1;//reset goes high
        #200
        reset = 1'b0;//reset goes low
        reg_check = 1'b1;//testing led output changing aacording to switch
        #100000//letting it run for a long time to see output
        reset = 1'b1;//reset after going for a while
        #200;
        $stop;
    end
    
    
    
endmodule
