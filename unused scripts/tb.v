`timescale 1ns / 1ns
`include "fp16multiplier.v"
module testbench;

    // Signals
    reg [15:0] a;
    reg [15:0] b;
    wire [15:0] result;

    // Instantiate the module
    multiplier dut (
        .a(a),
        .b(b),
        .out(result)
    );

    // Stimulus
    initial begin
        // Initialize inputs
        $monitor($time,"a=%b,b=%b,result=%b",a,b,result);
        #5
        b = 16'b0_01110_0000010101; // 0.5103 = 0 01110 0000010101
        a = 16'b0_01101_0000100011; // 0.2586 = 0 01101 0000100011
        //a=32'b00111111000000101010001100000101;
        //b=32'b00111110100001000110011100111000;
        #5
        // Finish simulation
        $finish;
    end

endmodule
