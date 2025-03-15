module TopModule (
    input logic do_sub,                // Control signal to select addition (0) or subtraction (1)
    input logic [7:0] a,               // First operand (8-bit unsigned)
    input logic [7:0] b,               // Second operand (8-bit unsigned)
    output logic [7:0] out,            // Output result (8-bit unsigned)
    output logic result_is_zero         // Zero flag (1-bit)
);

    always @(*) begin
        case (do_sub)
            1'b0: out = a + b;           // Perform addition
            1'b1: out = a - b;           // Perform subtraction
            default: out = 8'b00000000;  // Default case to prevent latches
        endcase

        result_is_zero = (out == 8'b00000000); // Set zero flag
    end

endmodule