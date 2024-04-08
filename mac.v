module FP16multiplier (
    input [15:0]a,
    input [15:0]b,
    output reg [15:0]result
);
    reg [4:0] expa,expb;
    reg [19:0] fraca,fracb;
    
    reg resultsign;
    reg [4:0]exp_reg;
    reg [20:0]product_reg;
    
    always @(*) begin
        //extract the exponents
        expa = a[14:10];
        expb = b[14:10];

        //extract the fraction(mantissa)
        fraca = a[9:0];
        fracb = b[9:0];
        
        //sign of the result by XORing the sign of the 2 numbers
        resultsign = a[15] ^ b[15];

        //calculate the exponent of the product, 1111(15) is a bias and is subtracted from the sum
        exp_reg = expa + expb - 5'd15;

        //calculate the product
        product_reg = (fraca * fracb) + {fraca,10'd0} + {fracb,10'd0};
        product_reg = product_reg >> 10;

        //Normalize to the product to 10 bits
        while (product_reg >= 20'd1024) begin
            product_reg = product_reg >> 1;
            exp_reg = exp_reg + 1;
        end

        //check for overflow(exponent >= 11111(31))
        if (exp_reg > 5'd30) begin
            result={1'b0, {5'd31}, {10'd0}};
            $display("overflow");
        end

        //check for underflow(exponent <0)
        else if (exp_reg < 5'd0) begin
            result={1'b0, {5'd0}, {10'd0}};
            $display("underflow");
        end

        else begin
            result={resultsign, exp_reg, product_reg[9:0]};
        end
    end
endmodule

module FP16adder (
    input [15:0]a,
    input [15:0]b,
    output reg [15:0]result
);
    reg signa,signb;
    reg [4:0] expa,expb;
    reg signed [19:0] fraca,fracb;

    reg [4:0] diff_exp;
    reg [4:0] result_exp;
    reg signed [19:0] shifted_a,shifted_b;
    reg signed [20:0] temp_sum;

    always @(*) begin
        //extract the signs
        signa = a[15];
        signb = b[15];

        //extract the exponents
        expa = a[14:10];
        expb = b[14:10];

        //extract the fraction(mantissa)
        fraca = {signa,9'd0,a[9:0]};
        fracb = {signb,9'd0,b[9:0]};        
        
        diff_exp = expa > expb ? expa - expb : expb - expa;

        if (diff_exp < 4'd10) begin
            result_exp = expa > expb ? expb : expa;
            shifted_a = {signa,9'd0,a[9:0] << diff_exp};
            shifted_b = {signb,9'd0,b[9:0] << diff_exp};
            temp_sum = expa > expb ? fracb + shifted_a + ({1'b1,9'd0} << diff_exp) : fraca + shifted_b + ({1'b1,9'd0} << diff_exp);
            $display("%b,%b,%b",fraca,fracb,temp_sum);
        end

        while (temp_sum >= 20'd1024) begin
            temp_sum = temp_sum >> 1;
            result_exp = result_exp + 1;
        end

        result = {temp_sum[20],result_exp,temp_sum[9:0]};





    end
endmodule