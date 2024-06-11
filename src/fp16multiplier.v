module multiplier(a, b, out);
    input  [15:0] a, b;
    output [15:0] out;

	reg a_sign;
    reg [4:0] a_exponent;
    reg [10:0] a_mantissa;

	reg b_sign;
    reg [4:0] b_exponent;
    reg [10:0] b_mantissa;

    reg o_sign;
    reg [4:0] o_exponent;
    reg [10:0] o_mantissa;

	reg [22:0] product;

    assign out = {o_sign,o_exponent,o_mantissa[9:0]};

	reg  [4:0] i_e;
	reg  [22:0] i_m;
	wire [4:0] o_e;
	wire [22:0] o_m;

	multiplication_normaliser norm1
	(
		.in_e(i_e),
		.in_m(i_m),
		.out_e(o_e),
		.out_m(o_m)
	);


    always @ ( * ) begin

		a_sign = a[15];
		if(a[14:10] == 0) begin
			a_exponent = 5'b00000;
			a_mantissa = {1'b0, a[9:0]}; //11th bit signifies whether it is a subnormal or normal number
			$display("a exp is 0");
		end else begin
			a_exponent = a[14:10];
			a_mantissa = {1'b1, a[9:0]};
			
		end

		b_sign = b[15];
		if(b[14:10] == 0) begin
			b_exponent = 5'b00000;
			b_mantissa = {1'b0, b[9:0]};
			$display("b exp is 0");
		end else begin
			b_exponent = b[14:10];
			b_mantissa = {1'b1, b[9:0]};
		end

    	o_sign = a_sign ^ b_sign;
    	o_exponent = (a_exponent + b_exponent > 5'd15) ? a_exponent + b_exponent - 5'd15 : 5'b00000 ;
		$display("initial-%b",o_exponent);
    	product = a_mantissa * b_mantissa;
		// Normalization
		if(product[21] == 1) begin
			o_exponent = o_exponent + 1;
			product = product >> 1;
			$display("1-%b",o_exponent);
		end else if((product[20] != 1) && (o_exponent != 0)) begin
			i_e = o_exponent;
			i_m = product;
			o_exponent = o_e;
			product = o_m;
			$display("2-%b",o_exponent);
		end
		o_mantissa = product[20:10];
	end
endmodule

module multiplication_normaliser(in_e, in_m, out_e, out_m);
  input [4:0] in_e;
  input [22:0] in_m;
  output [4:0] out_e;
  output [22:0] out_m;

  wire [4:0] in_e;
  wire [22:0] in_m;
  reg [4:0] out_e;
  reg [22:0] out_m;

  always @ ( * ) begin
	  if (in_m[21:16] == 6'b000001) begin
			out_e = in_e - 5;
			out_m = in_m << 5;
		end else if (in_m[21:17] == 5'b00001) begin
			out_e = in_e - 4;
			out_m = in_m << 4;
		end else if (in_m[21:18] == 4'b0001) begin
			out_e = in_e - 3;
			out_m = in_m << 3;
		end else if (in_m[21:19] == 3'b001) begin
			out_e = in_e - 2;
			out_m = in_m << 2;
		end else if (in_m[21:20] == 2'b01) begin
			out_e = in_e - 1;
			out_m = in_m << 1;
		end
  end
endmodule