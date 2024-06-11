`include "fp16adder.v"
`include "fp16multiplier.v"

module FP16MAC (A, B, result, clk, reset);
    input [15:0] A, B;
    input clk, reset;
    output [15:0] result;

    wire [15:0] product;
    wire [15:0] sum;
    
    reg [15:0] a,b;
    reg [15:0] product_reg;
    reg [15:0] accumulator;

    multiplier mul(.a(a),
                   .b(b),
                   .out(product)
    );

    adder add(.a(product_reg),
              .b(accumulator),
              .out(sum)
    );

    always @(posedge clk or negedge reset) begin
        if(!reset)begin
            a <= 16'd0;
            b <= 16'd0;
            product_reg <= 16'd0;
            accumulator <= 16'd0;
        end

        else begin
            //Stage 1: load data
            a <= A;
            b <= B;

            //Stage 2: multiply
            product_reg <= product;

            //Stage 3: add
            accumulator <= sum;
        end
    end

    assign result = accumulator;
endmodule
