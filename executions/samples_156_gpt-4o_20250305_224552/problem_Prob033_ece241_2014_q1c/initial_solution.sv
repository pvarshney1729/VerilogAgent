module TopModule(
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    // Addition operation
    assign s = a + b;
    
    // Overflow detection
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);
endmodule