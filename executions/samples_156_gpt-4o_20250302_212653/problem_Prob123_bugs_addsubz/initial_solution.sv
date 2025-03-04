`timescale 1ns/1ps

module TopModule (
    input logic do_sub,                // Control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,               // 8-bit input operand A
    input logic [7:0] b,               // 8-bit input operand B
    output logic [7:0] out,            // 8-bit output result
    output logic result_is_zero        // Output flag: 1 if result is zero
);

    // Combinational Logic
    always @(*) begin
        // Initialize defaults
        out = 8'b0;
        result_is_zero = 1'b0;

        // Select operation based on `do_sub`
        case (do_sub)
            1'b0: out = a + b;  // Addition when `do_sub` is 0
            1'b1: out = a - b;  // Subtraction when `do_sub` is 1
            default: out = 8'b0; // Default case for safety
        endcase

        // Set zero flag if the result is zero
        result_is_zero = (out == 8'b0) ? 1'b1 : 1'b0;
    end

endmodule