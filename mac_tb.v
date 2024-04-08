`timescale 1ns / 1ps
`include "mac.v"
module testbench;

    // Signals
    reg [15:0] a;
    reg [15:0] b;
    wire [15:0] result;

    // Instantiate the module
    FP16adder dut (
        .a(a),
        .b(b),
        .result(result)
    );

    // Stimulus
    initial begin
        // Initialize inputs
        $monitor($time,"a=%b,b=%b,result=%b",a,b,result);
        #5
        b = 16'b0_01110_0000010101; // 0.5103 = 0 01110 0000010101
        a = 16'b1_01101_0000100011; // 0.2586 = 0 01101 0000100011

        #5
        // Finish simulation
        $finish;
    end

endmodule
