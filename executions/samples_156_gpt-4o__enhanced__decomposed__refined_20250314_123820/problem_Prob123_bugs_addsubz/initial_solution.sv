[BEGIN]
module TopModule (
    input logic do_sub,             // 1-bit control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,            // 8-bit unsigned input operand A
    input logic [7:0] b,            // 8-bit unsigned input operand B
    output logic [7:0] out,         // 8-bit unsigned output result
    output logic result_is_zero     // 1-bit output flag, set to 1 if result is zero
);

always @(*) begin
    // Perform operation based on do_sub
    if (do_sub == 1'b0) begin
        out = a + b; // Perform addition
    end else begin
        out = a - b; // Perform subtraction
    end
    
    // Set zero flag
    result_is_zero = (out == 8'b00000000) ? 1'b1 : 1'b0;
end

endmodule
[DONE]