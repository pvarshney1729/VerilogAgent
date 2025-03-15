module TopModule(
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
);
    logic [8:0] sum; // 9-bit to capture carry out

    always @(*) begin
        sum = a + b; // Perform addition
        s = sum[7:0]; // Assign lower 8 bits to output
        // Overflow detection: check if carry into MSB is different from carry out
        overflow = (a[7] == b[7]) && (s[7] != a[7]);
    end
endmodule