module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
);
    logic [8:0] sum; // 9 bits to capture overflow

    always @(*) begin
        sum = {1'b0, a} + {1'b0, b}; // Add with sign extension
        s = sum[7:0]; // Assign the lower 8 bits to s
        overflow = (a[7] == b[7]) && (s[7] != a[7]); // Check for overflow
    end
endmodule