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


module top_mod(
    input CCLK, reset, reg_check,
    output max_tick,
    output reg [10:0] lfsr_reg,// half reg length declared
    output wire [7:0] sseg,
    output wire [3:0] an
    );
    wire clock;//slowed down clock
    wire [20:0] full_reg, code_word_amt;//actual reg length
    wire [3:0] d_3, d_2, d_1, d_0;
    //instatiating clock divider
    clock my_clock (.CCLK(CCLK), .clkscale(32'd50_000_000), .clk(clock));//50_000_000 in testbench I used 50, this impacts the displays output as it's too fast, but I am mostly loking for display changes and I look at the internal counter to make sure it's counting properly
    
    //instatiated LFSR
    LFSR shifting 
    (.clk(clock), .sh_en(1'b1),
     .rst_n(reset), .max_tick_reg(max_tick),
     .count_C_word(code_word_amt), .Q_out(full_reg));
     
    // instantiate 7-seg LED display module
   disp_hex_mux disp_unit
      (.clk(CCLK), .reset(reset),
        .hex3(d_3), .hex2(d_2), .hex1(d_1), .hex0(d_0),
       .dp_in(4'b1111), .an(an), .sseg(sseg));
       

   // instantiate stopwatch
   stop_watch_if hex_t_dec
      (.clk(clock), .counter(code_word_amt), .clr(reset),//input counter added
       .d3(d_3), .d2(d_2), .d1(d_1), .d0(d_0) );//added .d3(d3)
       
    always @ * //runs always block when reg_check changes
        begin
            case(reg_check)//if reg_check changes
                1'b0: lfsr_reg <= full_reg[10:0];//checks if 0 if so displays only first 11 bits of reg
                1'b1: begin //checks if 1 if so displays only last 10 bits of reg
                        lfsr_reg[9:0] <= full_reg[20:11]; 
                        lfsr_reg[10] <= 1'b0;//as it's 21 bot 22 last bit must be 0
                    end
            endcase
        end
endmodule
