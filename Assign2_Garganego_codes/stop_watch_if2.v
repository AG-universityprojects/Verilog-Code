// Listing 4.18
module stop_watch_if
   (
    input wire clk, clr,//declaration of inputs
    input wire [20:0] counter,
    output wire [3:0] d3, d2, d1, d0//declaration outputs
   );

   // declaration of reg


   reg [3:0] d3_reg, d2_reg, d1_reg, d0_reg;//added d3 reg
   reg [3:0] d3_next, d2_next, d1_next, d0_next;//added d3 next
   reg [20:0] disp_counter;
   reg ms_tick;

   // body
   // register
    always @(posedge clk)//updates every clock cycle
        begin
            if (clr)//checks for rest
                begin//resets values
                    d0_next = 4'b0;
                    d1_next = 4'b0;
                    d2_next = 4'b0;
                    d3_next = 4'b0;//added clear value of d3_next = 0
                    disp_counter = 21'h0;//resets the displayed counter to 0
        end
        //updates outputs
        d3_reg = d3_next;//added d3 reg = d3 next
        d2_reg = d2_next;
        d1_reg = d1_next;
        d0_reg = d0_next;
      if(counter > disp_counter)begin//check if the actual counter is bigger than the displayed one
            ms_tick = 1'b1;//if so turn ms_tick to 1
            disp_counter = disp_counter + 1;//adds 1 to the display counter
        end
      else
        ms_tick = 1'b0;//if not the display remains the same
      
      if (ms_tick)//if ms tick is high then add 1
         if (d0_reg != 9)
            d0_next = d0_reg + 1;
         else              // reach XXX9
            begin
               d0_next = 4'b0;//d0_next is set 0 and 1 is added to d1_next
               if (d1_reg != 9)
                  d1_next = d1_reg + 1;
               else       // reach XX99
                  begin
                     d1_next = 4'b0;//d1_next is set 0 and 1 is added to d2_next
                     if (d2_reg != 9)//change from 5 to 9
                        d2_next = d2_reg + 1;
                     else // reach X999
                        begin////d2_next is set 0 and 1 is added to d3_next
                            d2_next = 4'b0;
                            if(d3_reg != 9)
                                d3_next = d3_reg + 1;
                             else   //reach 9999
                             d3_next = 4'b0;
                         end
                  end
            end
   end

   // output logic assigns dx_reg to dx
   assign d0 = d0_reg;
   assign d1 = d1_reg;
   assign d2 = d2_reg;
   assign d3 = d3_reg;//added d3 = d3 reg

endmodule