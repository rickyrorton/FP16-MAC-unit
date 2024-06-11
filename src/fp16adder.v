module adder(a, b, out);
  input  [15:0] a, b;
  output [15:0] out;

  wire [15:0] out;

	reg a_sign;
	reg [4:0] a_exponent;
	reg [10:0] a_mantissa;

	reg b_sign;
	reg [4:0] b_exponent;
	reg [10:0] b_mantissa;

  reg o_sign;
  reg [4:0] o_exponent;
  reg [11:0] o_mantissa;

  reg [4:0] diff;
  reg [10:0] tmp_mantissa;
  reg [4:0] tmp_exponent;


  reg  [4:0] i_e;
  reg  [11:0] i_m;
  wire [4:0] o_e;
  wire [11:0] o_m;

  addition_normaliser norm1
  (
    .in_e(i_e),
    .in_m(i_m),
    .out_e(o_e),
    .out_m(o_m)
  );

  assign out = {o_sign,o_exponent,o_mantissa[9:0]};

  always @ ( * ) begin

		a_sign = a[15];
		if(a[14:10] == 0) begin
			a_exponent = 5'b00000;
			a_mantissa = {1'b0, a[9:0]};
		end else begin
			a_exponent = a[14:10];
			a_mantissa = {1'b1, a[9:0]};
		end

		b_sign = b[15];
		if(b[14:10] == 0) begin
			b_exponent = 5'b00000;
			b_mantissa = {1'b0, b[9:0]};
		end else begin
			b_exponent = b[14:10];
			b_mantissa = {1'b1, b[9:0]};
		end

    if (a_exponent == b_exponent) begin // Equal exponents
      o_exponent = a_exponent;
      if (a_sign == b_sign) begin // Equal signs = add
        o_mantissa = a_mantissa + b_mantissa;
        //Signify to shift
        o_mantissa[11] = a_mantissa[10] || b_mantissa[10];
        $display("%b",o_mantissa[11]);
        o_sign = a_sign;
      end 
			
			else begin // Opposite signs = subtract
        if(a_mantissa > b_mantissa) begin
          o_mantissa = a_mantissa - b_mantissa;
          o_sign = a_sign;
        end 
				
				else begin
          o_mantissa = b_mantissa - a_mantissa;
          o_sign = b_sign;
        end
      end
    end 
		
		else begin //Unequal exponents
      if (a_exponent > b_exponent) begin // A is bigger
        o_exponent = a_exponent;
        o_sign = a_sign;
				diff = a_exponent - b_exponent;
        tmp_mantissa = b_mantissa >> diff;
        if (a_sign == b_sign)
          o_mantissa = a_mantissa + tmp_mantissa;
        else
          	o_mantissa = a_mantissa - tmp_mantissa;
      end 
			
			else if (a_exponent < b_exponent) begin // B is bigger
        o_exponent = b_exponent;
        o_sign = b_sign;
        diff = b_exponent - a_exponent;
        tmp_mantissa = a_mantissa >> diff;
        if (a_sign == b_sign) begin
          o_mantissa = b_mantissa + tmp_mantissa;
        end 
				else begin
					o_mantissa = b_mantissa - tmp_mantissa;
        end
      end
    end
    
    if(o_mantissa[11] == 1) begin
      o_exponent = o_exponent + 1;
      o_mantissa = o_mantissa >> 1;
      $display("idek1");
    end 
		
		else if((o_mantissa[10] != 1) && (o_exponent != 0)) begin
      i_e = o_exponent;
      i_m = o_mantissa;
      o_exponent = o_e;
      o_mantissa = o_m;
      $display("idek2");
    end
    
  end
endmodule

module addition_normaliser(in_e, in_m, out_e, out_m);
  input [4:0] in_e;
  input [11:0] in_m;
  output [4:0] out_e;
  output [11:0] out_m;

  wire [4:0] in_e;
  wire [11:0] in_m;
  reg [4:0] out_e;
  reg [11:0] out_m;

  always @ ( * ) begin
		if (in_m[10:3] == 8'b00000001) begin
			out_e = in_e - 7;
			out_m = in_m << 7;
		end else if (in_m[10:4] == 7'b0000001) begin
			out_e = in_e - 6;
			out_m = in_m << 6;
		end else if (in_m[10:5] == 6'b000001) begin
			out_e = in_e - 5;
			out_m = in_m << 5;
		end else if (in_m[10:6] == 5'b00001) begin
			out_e = in_e - 4;
			out_m = in_m << 4;
		end else if (in_m[10:7] == 4'b0001) begin
			out_e = in_e - 3;
			out_m = in_m << 3;
		end else if (in_m[10:8] == 3'b001) begin
			out_e = in_e - 2;
			out_m = in_m << 2;
		end else if (in_m[10:9] == 2'b01) begin
			out_e = in_e - 1;
			out_m = in_m << 1;
    end else begin
      out_e = in_e;
			out_m = in_m;
    end
  end
endmodule