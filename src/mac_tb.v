`timescale 1ns/1ps
`include "fp16MAC.v"

module FP16MAC_tb;

    // Inputs
    reg [15:0] A;
    reg [15:0] B;
    reg clk;
    reg reset;

    // Outputs
    wire [15:0] result;

    // Instantiate the Unit Under Test (UUT)
    FP16MAC uut (
        .A(A), 
        .B(B), 
        .result(result), 
        .clk(clk), 
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 ns
    end

    // Test vectors
    initial begin
        // Initialize Inputs
        A = 0;
        B = 0;
        reset = 1;

        // Wait 100 ns for global reset to finish
        #20;
        
        // Apply reset
        reset = 0;
        #10;
        reset = 1;

        

        // Test Case 1: Multiply and accumulate (2.5 * 4.0)
        A = 16'h4200; // 3.0 in IEEE 754 half-precision format
        B = 16'h4400; // 4.0 in IEEE 754 half-precision format
        #10;

        // Test Case 2: Multiply and accumulate (1.5 * 3.0)
        A = 16'h3E00; // 1.5 in IEEE 754 half-precision format
        B = 16'h4040; // 2.125 in IEEE 754 half-precision format
        #10;

        // Test Case 3: Multiply and accumulate (0.5 * 2.0)
        A = 16'h3800; // 0.5 in IEEE 754 half-precision format
        B = 16'h4000; // 2.0 in IEEE 754 half-precision format
        #10;

        // Add more test cases as needed
        A = 16'h0000;
        B = 16'h0000;
        #40;

        reset = 1;

        // Wait 100 ns for global reset to finish
        #20;
        
        // Apply reset
        reset = 0;
        #10;
        reset = 1;
        #10;

        A = 16'h4200; // 3.0 in IEEE 754 half-precision format
        B = 16'h4400; // 4.0 in IEEE 754 half-precision format
        #10;

        // Test Case 2: Multiply and accumulate (1.5 * 3.0)
        A = 16'h3E00; // 1.5 in IEEE 754 half-precision format
        B = 16'h4040; // 2.125 in IEEE 754 half-precision format
        #10;

        // Test Case 3: Multiply and accumulate (0.5 * 2.0)
        A = 16'h3800; // 0.5 in IEEE 754 half-precision format
        B = 16'h4000; // 2.0 in IEEE 754 half-precision format
        #10;

        // Add more test cases as needed
        A = 16'h0000;
        B = 16'h0000;
        #40;

        // Finish simulation
        $finish;
    end

    // Monitor the output
    initial begin
        $monitor("Time = %0d : A = %h, B = %h, result = %b", $time, A, B, result);
        $dumpfile("fpu_tb.vcd");
        $dumpvars(0,FP16MAC_tb);
    end

endmodule
