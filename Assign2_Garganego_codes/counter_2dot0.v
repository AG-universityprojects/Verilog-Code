`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2025 20:23:25
// Design Name: 
// Module Name: counter
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


module counter
#(parameter N = 21)(//parameter for taplength N bits declared, codeword 6'b010101
    input clk, rst, q_bit, en,//input values declared
    output reg [N-1:0] code_out  //output counter declared
    );
    parameter wt=6'b000_000, strt=6'b000_001, secnd=6'b000_010, thrd=6'b000_011, frth=6'b000_100, ffth=6'b000_101;//local parameter decleration for steps
    reg [5:0] str, n_str;
    
        
    always @ (posedge clk)//checks only at clock cycle
        begin
            if (rst)//cheks if reset is high
                begin
                    str = wt;//resets steps
                    code_out =21'b0;//resets code counter
                end
            else str = n_str;// else str is equal to next value
            n_str = str;//setting str to the new str
            if(en)begin// if bit shifting is high
                    case(str)//checks at what step of the code word we are at
                    wt: if(q_bit == 1'b0) //check for 0
                            n_str = strt;//goes to next step
                        else n_str = wt;//if not 0 go back to reset
                        
                    strt: if(q_bit == 1'b1) //check for 1
                            n_str = secnd;//goes to next step
                        else n_str = strt;//goes back to check for 1 as 0 is initial value
                        
                    secnd: if(q_bit == 1'b0) //check for 0
                            n_str = thrd;//goes to next step
                    else n_str = wt;//if not 0 go back to reset
                    
                    thrd: if(q_bit == 1'b1) //check for 1
                            n_str = frth;//goes to next step
                    else n_str = strt;//goes back to check for 1 as 0 is initial value
                    
                    frth: if(q_bit == 1'b0) //check for 0
                            n_str = ffth;//moves to next bit
                    else n_str = wt;//if not 0 go back to reset
                    
                    ffth: if(q_bit == 1'b1) begin //check for 1
                        n_str = frth;//if condition is met the signal could be repeated as it repeats
                        code_out = code_out + 1;//adds 1 to counter
                    end
                    else n_str = strt;//goes back to check for 1 as 0 is initial value
                    default: n_str = wt;//if str random variable it's set to wt
                endcase
            end
        end
endmodule
