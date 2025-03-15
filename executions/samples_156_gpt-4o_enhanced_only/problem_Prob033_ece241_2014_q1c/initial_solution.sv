module TopModule(
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
);

    always @(*) begin
        // Perform the addition
        s = a + b;
        
        // Check for signed overflow
        // Overflow occurs if:
        // - MSB of a and b are the same and different from the MSB of the result s
        overflow = (a[7] == b[7]) && (s[7] != a[7]);
    end

endmodule