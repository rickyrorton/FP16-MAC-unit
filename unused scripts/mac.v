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
        $display("%b",fraca);
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

    reg [4:0] exp_diff;
    reg [20:0] temp_sum;

    reg [4:0] exp_reg;
    reg resultsign;

    always @(*) begin
        //extract the exponents
        expa = a[14:10];
        expb = b[14:10];

        //extract the fraction(mantissa)
        fraca = a[9:0];
        fracb = b[9:0];

        //extract the signs
        signa=a[15];
        signb=b[15];
        if (signa==signb)begin
            resultsign = signa;
            if (expa>expb)begin
                exp_diff = expa - expb;
                exp_reg = expb;
                temp_sum = {1'b1,9'b0} + fraca;
                temp_sum = temp_sum << exp_diff;
                temp_sum = temp_sum + fracb;
            end

            else begin
                exp_diff = expb - expa;
                exp_reg = expa;
                temp_sum = {1'b1,9'b0} + fracb;
                temp_sum = temp_sum << exp_diff;
                temp_sum = temp_sum + fraca;
            end
        end
        
        else begin
            if (expa>expb)begin
                resultsign = signa;
                exp_diff = expa - expb;
                exp_reg = expb;
                temp_sum = {1'b1,9'b0} + fraca;
                temp_sum = temp_sum << exp_diff;
                temp_sum = temp_sum - (fracb+{1'b1,10'b0});
            end

            else begin
                resultsign = signb;
                exp_diff = expb - expa;
                exp_reg = expa;
                temp_sum = {1'b1,9'b0} + fracb;
                temp_sum = temp_sum << exp_diff;
                temp_sum = temp_sum - (fraca+{1'b1,10'b0});
            end
        end
        //normalize
        while (temp_sum >= 20'd1024) begin
            temp_sum = temp_sum >> 1;
            exp_reg = exp_reg + 1;
        end
        
        result = {resultsign,exp_reg,temp_sum[9:0]};

    end
    
endmodule