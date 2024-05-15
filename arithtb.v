`timescale 1ns / 1ns
`include "signedarith.v"
module testbench;

    // Signals
    reg [8:0]x,y;
    reg signed [8:0] a,b;
    wire signed [9:0] result;

    // Instantiate the module
    signarith dut (a,b,result);

    // Stimulus
    initial begin
        // Initialize inputs
        $monitor($time,"a=%d,b=%d,result=%d,%b",a,b,result,result);
        #5
        x = 9'b1_11111111;
        y = 9'b1_11000001;
        a=x[8]? {1'b1,-x[7:0]} : {1'b0,x[7:0]} ;
        b=y[8]? {1'b1,-y[7:0]} : {1'b0,y[7:0]} ;
        #5
        // Finish simulation
        $finish;
    end

endmodule
