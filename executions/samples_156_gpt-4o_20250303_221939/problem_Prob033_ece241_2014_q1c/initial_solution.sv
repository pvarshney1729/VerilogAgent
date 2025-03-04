module TopModule(
    input signed [7:0] a,
    input signed [7:0] b,
    output signed [7:0] s,
    output logic overflow
);

    assign s = a + b;

    always @(*) begin
        // Detect signed overflow
        overflow = (a[7] == b[7]) && (s[7] != a[7]);
    end

endmodule