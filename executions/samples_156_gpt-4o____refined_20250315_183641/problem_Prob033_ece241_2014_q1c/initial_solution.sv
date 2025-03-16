module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
);

    logic [8:0] sum; // 9-bit to capture overflow

    always @(*) begin
        sum = a + b;
        s = sum[7:0];
        // Overflow detection for 2's complement addition
        overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);
    end

endmodule