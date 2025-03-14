module TopModule (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
);

always @(*) begin
    logic signed [8:0] temp_sum; // Temporary sum with an extra bit to detect overflow
    temp_sum = {1'b0, a} + {1'b0, b}; // Zero-extend to 9 bits for overflow detection

    // Assign the result and overflow flag
    s = temp_sum[7:0]; // Assign the lower 8 bits to output
    overflow = (temp_sum[8] != temp_sum[7]); // Overflow occurs if sign bits differ
end

endmodule