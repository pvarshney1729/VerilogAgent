module TopModule(
    input signed [7:0] a,
    input signed [7:0] b,
    output signed [7:0] s,
    output logic overflow
);

    logic signed [8:0] sum; // Use 9 bits to detect overflow

    always @(*) begin
        sum = a + b;
        s = sum[7:0]; // Assign the lower 8 bits to s
        // Check for overflow
        overflow = (a[7] == b[7]) && (sum[7] != a[7]);
    end

endmodule