module TopModule (
    input  logic [7:0] a,         // 8-bit input, MSB is bit 7
    input  logic [7:0] b,         // 8-bit input, MSB is bit 7
    output logic [7:0] s,         // 8-bit output, MSB is bit 7
    output logic       overflow   // 1-bit output indicating signed overflow
);

    always @(*) begin
        s = a + b;
        overflow = ((a[7] == b[7]) && (s[7] != a[7]));
    end

endmodule