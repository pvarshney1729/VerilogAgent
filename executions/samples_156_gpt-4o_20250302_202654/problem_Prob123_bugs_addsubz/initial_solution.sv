module TopModule (
    input logic do_sub,           // Control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,          // 8-bit input operand `a`
    input logic [7:0] b,          // 8-bit input operand `b`
    output logic [7:0] out,       // 8-bit output result
    output logic result_is_zero   // Zero flag: 1 if `out` is zero, else 0
);

    // Combinational logic: Operates based on the inputs without any clock dependency
    always @(*) begin
        // Perform addition or subtraction based on `do_sub`
        case (do_sub)
            1'b0: out = a + b;   // Addition
            1'b1: out = a - b;   // Subtraction
            default: out = 8'b0; // Default case, though not strictly necessary for a 1-bit control
        endcase

        // Zero flag logic: Assert flag if the output is zero
        result_is_zero = (out == 8'b0);
    end

endmodule