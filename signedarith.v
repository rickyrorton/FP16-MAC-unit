module signarith (A,B,C);
    input signed [8:0]A,B;
    output signed[9:0]C;
    assign C=A+B;
    //{A[7],A}+{B[7],B};
    
endmodule