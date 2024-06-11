module Subtractor5Bit(
    input [4:0] a,       // 5-bit input a
    input [4:0] b,       // 5-bit input b
    output [4:0] result, // 5-bit result
    output borrow_out    // Borrow out
);

    wire [5:0] b_ext = {1'b0, b};  // Extend b to 6 bits with a leading 0
    wire [5:0] a_ext = {1'b0, a};  // Extend a to 6 bits with a leading 0
    wire [5:0] sub_result;

    // Perform subtraction
    assign sub_result = a_ext - b_ext;

    // Assign result and borrow_out
    assign result = sub_result[5] ? -sub_result[4:0] : sub_result[4:0] ;
    assign borrow_out = sub_result[5];

endmodule
