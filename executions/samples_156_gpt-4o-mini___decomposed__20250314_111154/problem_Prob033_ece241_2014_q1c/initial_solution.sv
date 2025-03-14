module TopModule (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
);
    logic signed [8:0] sum; // 9-bit to hold the sum and detect overflow

    assign sum = {1'b0, a} + {1'b0, b}; // Extend a and b to 9 bits and add
    assign s = sum[7:0]; // Assign the lower 8 bits to output s
    assign overflow = (a[7] == b[7]) && (a[7] != s[7]); // Overflow condition
endmodule