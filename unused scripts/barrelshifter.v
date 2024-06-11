module barrel_shifter_11bit (
    input [10:0] data_in,
    input [3:0] shift_amount,
    output [10:0] data_out
);
    wire [10:0] stage1, stage2, stage3;

    // Stage 1: 1-bit shift
    assign stage1 = shift_amount[0] ? {data_in[9:0], 1'b0} : data_in;

    // Stage 2: 2-bit shift
    assign stage2 = shift_amount[1] ? {stage1[8:0], 2'b00} : stage1;

    // Stage 3: 4-bit shift
    assign stage3 = shift_amount[2] ? {stage2[6:0], 4'b0000} : stage2;

    // Stage 4: 8-bit shift
    assign data_out = shift_amount[3] ? {stage3[2:0], 8'b00000000} : stage3;

endmodule
