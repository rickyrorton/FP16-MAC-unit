
module testbench;
    reg [15:0] num1;
    reg [15:0] num2;
    wire [15:0] sum;

    // Instantiate the DUT (Device Under Test)
    floating_point_adder dut (
        .a(num1),
        .b(num2),
        .sum(sum)
    );

    initial begin
        $monitor("num1: %h, num2: %h, sum: %h", num1, num2, sum);


        // Test case 1
        #10 num1 = 16'b0010111001110100; num2 = 16'b0011001001111100;
        #10 if (sum !== 16'b0011010011011011) $display("Error: expected %h, got %h", 16'b0011010011011011, sum);
    
        // Test case 2
        #10 num1 = 16'b0011000110111111; num2 = 16'b0011100001011110;
        #10 if (sum !== 16'b0011100111001110) $display("Error: expected %h, got %h", 16'b0011100111001110, sum);
    
        // Test case 3
        #10 num1 = 16'b0011010111101100; num2 = 16'b0011100001011100;
        #10 if (sum !== 16'b0011101101010010) $display("Error: expected %h, got %h", 16'b0011101101010010, sum);
    
        // Test case 4
        #10 num1 = 16'b0011010011100111; num2 = 16'b0011101110111100;
        #10 if (sum !== 16'b0011110100011000) $display("Error: expected %h, got %h", 16'b0011110100011000, sum);
    
        // Test case 5
        #10 num1 = 16'b0011011010110110; num2 = 16'b0011011110110110;
        #10 if (sum !== 16'b0011101100110110) $display("Error: expected %h, got %h", 16'b0011101100110110, sum);
    
        // Test case 6
        #10 num1 = 16'b0011101000111101; num2 = 16'b0011100110011000;
        #10 if (sum !== 16'b0011110111101010) $display("Error: expected %h, got %h", 16'b0011110111101010, sum);
    
        // Test case 7
        #10 num1 = 16'b0011100011101010; num2 = 16'b0011101010111000;
        #10 if (sum !== 16'b0011110111010001) $display("Error: expected %h, got %h", 16'b0011110111010001, sum);
    
        // Test case 8
        #10 num1 = 16'b0011100000101011; num2 = 16'b0011101000100010;
        #10 if (sum !== 16'b0011110100100110) $display("Error: expected %h, got %h", 16'b0011110100100110, sum);
    
        // Test case 9
        #10 num1 = 16'b0011101000100100; num2 = 16'b0010101010010100;
        #10 if (sum !== 16'b0011101010001101) $display("Error: expected %h, got %h", 16'b0011101010001101, sum);
    
        // Test case 10
        #10 num1 = 16'b0011101110010001; num2 = 16'b0011000111101011;
        #10 if (sum !== 16'b0011110010000110) $display("Error: expected %h, got %h", 16'b0011110010000110, sum);
    
        $finish;
    end
endmodule
