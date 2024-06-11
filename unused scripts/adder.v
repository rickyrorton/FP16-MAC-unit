module half_adder(a,b,s,c);
    input a,b;
    output s,c;
    
    xor x1(s,a,b);
    and a1(c,a,b);
endmodule

module full_adder(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    wire x,y,z;

    half_adder h1 (a,b,x,y);
    half_adder h2 (x,cin,sum,z);
    or o1(cout,y,z);

endmodule

module paralleladder11bit (a,b,cin,sum,cout);
    input [10:0]a,b;
    input cin;
    
    output cout;
    output [10:0]sum;

    wire [9:0]c;

    full_adder fa0(a[0],b[0],cin,sum[0],c[0]);
    full_adder fa1(a[1],b[1],c[0],sum[1],c[1]);
    full_adder fa2(a[2],b[2],c[1],sum[2],c[2]);
    full_adder fa3(a[3],b[3],c[2],sum[3],c[3]);
    full_adder fa4(a[4],b[4],c[3],sum[4],c[4]);
    full_adder fa5(a[5],b[5],c[4],sum[5],c[5]);
    full_adder fa6(a[6],b[6],c[5],sum[6],c[6]);
    full_adder fa7(a[7],b[7],c[6],sum[7],c[7]);
    full_adder fa8(a[8],b[8],c[7],sum[8],c[8]);
    full_adder fa9(a[9],b[9],c[8],sum[9],c[9]);
    full_adder fa10(a[10],b[10],c[9],sum[10],cout);

endmodule