module TopModule (
    input logic do_sub,          // Single-bit control signal for operation mode
    input logic [7:0] a,         // 8-bit input operand
    input logic [7:0] b,         // 8-bit input operand
    output logic [7:0] out,      // 8-bit output result
    output logic result_is_zero  // Single-bit zero flag
);

    // Combinational logic block
    always_comb begin
        // Arithmetic operation based on do_sub signal
        case (do_sub)
            1'b0: out = a + b;    // Addition operation
            1'b1: out = a - b;    // Subtraction operation
            default: out = 8'b0;  // Default case for safety
        endcase

        // Determine if the result is zero
        result_is_zero = (out == 8'b0);
    end

endmodule