`include "fp16adder.v"
module adder_tb;
  // Inputs
  reg [15:0] a;
  reg [15:0] b;

  // Outputs
  wire [15:0] out;

  // Instantiate the adder
  adder uut (
    .a(a),
    .b(b),
    .out(out)
  );

  initial begin
    // Initialize inputs
    a = 0;
    b = 0;

    // Monitor the changes
    $monitor("Time: %0t | a: %b | b: %b | out: %h", $time, a, b, out);

    // Apply test vectors
    //#10 a = 16'h3C00; b = 16'h4000;  // Test 1: 1.0 + 2.0
    #10 a = 16'h7BFF; b = 16'h7BFF;  // Test 2: -2.0 + 2.0
    //#10 a = 16'h0001; b = 16'h0002;  // Test 3: 1.0 + (-1.0)
    //#10 a = 16'h4000; b = 16'h3C00;  // Test 4: 2.0 + 1.0
    //#10 a = 16'h0000; b = 16'h0000;  // Test 5: 0.0 + 0.0

    // Add more test vectors as needed

    // Finish the simulation
    #10 $finish;
  end
endmodule
