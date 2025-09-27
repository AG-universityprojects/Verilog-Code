`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2025 00:41:50
// Design Name: 
// Module Name: top
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


module top(
    input CCLK, reset, reg_check,
    output max_tick,
    output reg [8:0] lfsr_reg// half reg length declared
    );
    wire clock;//slowed down clock
    wire [17:0] full_reg;//actual reg length
    clock my_clock (.CCLK(CCLK), .clkscale(32'd50_000_000), .clk(clock));
    LFSR_without_counter shifting (.clk(clock), .sh_en(1'b1), .rst_n(reset), .max_tick_reg(max_tick), .Q_out(full_reg));
    always @ (reg_check) //runs always block when reg_check changes
        begin
            case(reg_check)//if reg_check changes
                1'b0: lfsr_reg <= full_reg[8:0];//checks if 0 if so displays only first 9 bits of reg
                1'b1: lfsr_reg <= full_reg[17:9];//checks if 1 if so displays only last 9 bits of reg
            endcase
        end
endmodule
