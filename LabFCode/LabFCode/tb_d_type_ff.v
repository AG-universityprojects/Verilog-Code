`timescale 1ns/1ns

module testbench;
    reg clk, re_set, i1;//decleration of input wires
    wire outsie;//output wires
    
    d_ff_reset uut (.clk(clk), .reset(re_set), .d(i1), .q(outsie));//decleration of clock
   
    
    initial begin   //initialising clock
        clk = 1'b1;    
    forever
    #10 clk = !clk; //every 5ns, invert
    end
    
    initial//initialising the input resets variables
    begin
        re_set = 1'b1;
        #40
        re_set = !re_set;
        i1 = 1'b1;
        #80
        re_set = !re_set;
        i1 = 1'b1;
        #20  
        re_set = !re_set;
    end
    
    initial//initialising reg value
    begin
        i1 = 1'b0;
        #20
        i1 = !i1;
        #32
        i1 = !i1;
        #21
        i1 = !i1;
        #100
        i1 = !i1;
        #47
    $stop;  
    end
   
endmodule