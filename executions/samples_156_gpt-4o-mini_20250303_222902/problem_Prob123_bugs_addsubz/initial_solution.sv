module TopModule (
    input logic do_sub,                  // 1-bit control signal for addition/subtraction
    input logic [7:0] a,                 // 8-bit input operand 'a'
    input logic [7:0] b,                 // 8-bit input operand 'b'
    output logic [7:0] out,               // 8-bit result of the operation
    output logic result_is_zero           // 1-bit flag indicating if result is zero
);

    // Define behavior for combinational logic
    always @(*) begin
        // Perform operation based on do_sub control signal
        if (do_sub == 1'b0) begin
            out = a + b;               // Perform addition
        end else begin
            out = a - b;               // Perform subtraction
        end

        // Set result_is_zero flag based on the result
        if (out == 8'b0) begin
            result_is_zero = 1'b1;     // Set flag if result is zero
        end else begin
            result_is_zero = 1'b0;     // Reset flag otherwise
        end
    end

    // Define initial states for simulation purposes
    initial begin
        out = 8'b0;                    // Initialize output to zero
        result_is_zero = 1'b0;         // Initialize zero flag to low
    end

endmodule