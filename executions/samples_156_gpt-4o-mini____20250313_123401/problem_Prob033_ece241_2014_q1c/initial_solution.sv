module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
);
    logic [8:0] sum; // 9 bits to capture overflow

    always @(*) begin
        sum = {1'b0, a} + {1'b0, b}; // Extend to 9 bits for addition
        s = sum[7:0]; // Lower 8 bits are the result
        overflow = (a[7] == b[7]) && (s[7] != a[7]); // Check for overflow
    end
endmodule