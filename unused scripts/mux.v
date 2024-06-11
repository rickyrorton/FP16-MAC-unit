module mux2to1_10 (a,b,s,y);
    input [9:0]a,b;
    input s;
    output y;

    assign y = s ? b : a ;
endmodule


module mux2to1_5 (a,b,s,y);
    input [4:0]a,b;
    input s;
    output y;

    assign y = s ? b : a ;
endmodule