`include "fp16multiplier.v"
module multiplier_tb;
  reg [15:0] a, b;
  wire [15:0] out;

  // Instantiate the multiplier module
  multiplier uut (
    .a(a),
    .b(b),
    .out(out)
  );

  initial begin
    // Initialize signals
    $monitor("a = %h, b = %h, out = %h", a, b, out);

    // Test case 1
    a = 16'h4200; // 2.5 in 5-bit exponent, 11-bit mantissa
    b = 16'h4400; // 1.25 in 5-bit exponent, 11-bit mantissa
    #10;

    // Test case 2
    //a = 16'b1100000100000000; // -2.5 in 5-bit exponent, 11-bit mantissa
    //b = 16'b0100000010000000; // 1.25 in 5-bit exponent, 11-bit mantissa
    //#10;

    // Test case 3
    //a = 16'b0100000100000000; // 2.5 in 5-bit exponent, 11-bit mantissa
    //b = 16'b1100000010000000; // -1.25 in 5-bit exponent, 11-bit mantissa
    //#10;

    // Test case 4
    //a = 16'b1100000100000000; // -2.5 in 5-bit exponent, 11-bit mantissa
    //b = 16'b1100000010000000; // -1.25 in 5-bit exponent, 11-bit mantissa
    //#10;

    // Add more test cases as needed

    // Finish simulation
    $finish;
  end
endmodule
