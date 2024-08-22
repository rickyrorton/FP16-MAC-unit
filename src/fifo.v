module fifo #(parameter DEPTH=1024, DATA_WIDTH=16) (
  input clk, rst_n,
  input w_en, r_en,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output full, empty
);
  
  reg [DATA_WIDTH-1:0] fifo [DEPTH-1:0];  // Correct 2D array declaration
  reg [$clog2(DEPTH)-1:0] w_ptr, r_ptr;  // Adjusted pointer width to match DEPTH
  
  // Set Default values on reset.
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      w_ptr <= 0;
      r_ptr <= 0;
      data_out <= 0;
    end
  end
  
  // To write data to FIFO
  always @(posedge clk) begin
    if(w_en & !full) begin
      fifo[w_ptr] <= data_in;
      w_ptr <= w_ptr + 1;
    end
  end
  
  // To read data from FIFO
  always @(posedge clk) begin
    if(r_en & !empty) begin
      data_out <= fifo[r_ptr];
      r_ptr <= r_ptr + 1;
    end
  end
  
  assign full = (w_ptr + 1 == r_ptr) || (w_ptr == DEPTH-1 && r_ptr == 0); // Adjusted full condition
  assign empty = (w_ptr == r_ptr);
endmodule
