// Listing 4.2
module tempstore
   (
    input wire clk, reset,//declared inputs
    input wire [4:0] button_input,
    output wire [3:0] anode_sel,//declared outputs
    output wire [6:0] led_out
   );
    
    wire [7:0] q;//reg val
    reg [7:0] q_next;//next reg val
    wire [4:0] bttn;//button inputs
    
    always @(posedge clk) begin
        case (bttn[4:0])
            5'b00_001, 5'b00_010: q_next = q + 1;// if right or up button pressed increment reg
            5'b00_100, 5'b01_000: q_next = q - 1;// if left or down button pressed increment reg
            5'b10_000: q_next = 8'b0010110;// when middle button is pressed next reg value is set to 22
            default: q_next = q;//default case is set to q value
            endcase
      end
    // q output updated with q_next into memory
    d_ff_reset DFF0 (.clk(clk), .reset(reset), .d(q_next[0]), .q(q[0]));
    d_ff_reset DFF1 (.clk(clk), .reset(reset), .d(q_next[1]), .q(q[1]));
    d_ff_reset DFF2 (.clk(clk), .reset(reset), .d(q_next[2]), .q(q[2]));
    d_ff_reset DFF3 (.clk(clk), .reset(reset), .d(q_next[3]), .q(q[3]));
    d_ff_reset DFF4 (.clk(clk), .reset(reset), .d(q_next[4]), .q(q[4]));
    d_ff_reset DFF5 (.clk(clk), .reset(reset), .d(q_next[5]), .q(q[5]));
    d_ff_reset DFF6 (.clk(clk), .reset(reset), .d(q_next[6]), .q(q[6]));
    d_ff_reset DFF7 (.clk(clk), .reset(reset), .d(q_next[7]), .q(q[7]));
    
    seven_segment_controller unt_w(.clk(clk), .reset(reset), .temp(q), .anode_select(anode_sel), .LED_out(led_out)); // decleration of modules
    debouncer ioualom ( .clk(clk),.reset(reset), .button_in(button_input), .button_out(bttn));
    
endmodule