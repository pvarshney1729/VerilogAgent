module combinational_design (
    input logic clk,
    input logic reset,
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] result,
    output logic overflow,
    output logic underflow
);

logic [8:0] sum; // Extra bit for overflow detection

always @(*) begin
    if (reset) begin
        result = 8'b00000000;
        overflow = 1'b0;
        underflow = 1'b0;
    end else begin
        sum = {1'b0, a} + {1'b0, b}; // Perform addition with overflow bit
        result = sum[7:0]; // Assign lower 8 bits to result
        overflow = sum[8]; // Set overflow if the 9th bit is set
        underflow = 1'b0; // Underflow handling can be added if needed
    end
end

endmodule