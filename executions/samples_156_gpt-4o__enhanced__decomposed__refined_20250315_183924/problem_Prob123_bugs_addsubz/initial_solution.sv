module TopModule (
    input wire do_sub,                   // 1-bit control signal: 0 for addition, 1 for subtraction
    input wire [7:0] a,                  // 8-bit unsigned operand a
    input wire [7:0] b,                  // 8-bit unsigned operand b
    output reg [7:0] out,                // 8-bit unsigned result of the operation
    output reg result_is_zero            // 1-bit flag indicating if the result is zero
);

    // Combinational logic for adder-subtractor with zero detection
    always @(*) begin
        // Perform addition or subtraction based on the control signal
        case (do_sub)
            1'b0: out = a + b;           // Addition when do_sub is 0
            1'b1: out = a - b;           // Subtraction when do_sub is 1
            default: out = 8'b0;         // Default case for safety (though should not occur)
        endcase

        // Set the zero flag based on the output
        result_is_zero = (out == 8'b0) ? 1'b1 : 1'b0; // 1 if out is zero, otherwise 0
    end

endmodule