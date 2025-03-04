module TopModule (
    input logic do_sub,                // Single-bit input for operation selection: 0 for add, 1 for subtract
    input logic [7:0] a,               // 8-bit input operand a
    input logic [7:0] b,               // 8-bit input operand b
    output logic [7:0] out,             // 8-bit output for the result of the operation
    output logic result_is_zero         // Single-bit output flag indicating if the result is zero
);

    // Combinational Logic Block for Addition/Subtraction
    always @(*) begin
        // Perform addition or subtraction based on do_sub
        if (do_sub == 1'b0)
            out = a + b;              // Perform addition
        else
            out = a - b;              // Perform subtraction
        
        // Zero Detection Logic
        result_is_zero = (out == 8'b00000000); // Set flag if result is zero
    end

endmodule