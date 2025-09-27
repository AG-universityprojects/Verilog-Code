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
#(parameter N = 18)(//parameter of N bits declared
    input clk, rst, q_bit, en, max,//input values declared
    output reg [N-1:0] out_0, out_1  //output counter values declared
    );
    always @ (posedge clk) begin
        if(!rst && en)begin//checking for reset not being on and enable is on else it ignores the qbit
            case (q_bit)
                1'b0: out_0 <= out_0 + 1;//incrementing 0 counter when 0 val
                1'b1: out_1 <= out_1 + 1;//incrementing 1 counter when 1 val
            endcase
        end
    end
    always @ (posedge rst, posedge max) begin//resets at reset and when the max is reached
        out_0 <= 18'h0;//resets counter to 0
        out_1 <= 18'h0;//resets counter to 0
    end
endmodule
