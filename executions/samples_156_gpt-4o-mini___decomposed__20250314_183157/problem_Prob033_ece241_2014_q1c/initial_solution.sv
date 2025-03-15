module TopModule (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
);
    logic [8:0] sum; // 9-bit sum for overflow detection

    assign sum = {1'b0, a} + {1'b0, b}; // Extend to 9 bits
    assign s = sum[7:0];
    assign overflow = (a[7] == b[7]) && (a[7] != sum[7]); // Overflow detection logic
endmodule