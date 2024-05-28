module mux2to1 (a,b,s,y);
    input [9:0]a,b;
    input s;
    output y;

    assign y = s ? b : a ;
endmodule
