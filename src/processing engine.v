module weights_buf (in,out,clk,reset);
    input [15:0]in;
    input clk,reset;  
    output reg [15:0]out;

    reg [15:0]buffer[127:0]

    always @(posedge clk or reset) begin
        if (!reset)begin
            
        end
    end
endmodule