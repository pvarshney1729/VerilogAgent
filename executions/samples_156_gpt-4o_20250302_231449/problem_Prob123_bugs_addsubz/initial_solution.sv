```verilog
module TopModule (
    input logic do_sub,             // Control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,            // 8-bit operand a
    input logic [7:0] b,            // 8-bit operand b
    output logic [7:0] out,         // 8-bit result of operation
    output logic result_is_zero     // Flag indicating if result is zero
);

    // Define the combinational logic for addition and subtraction
    always_comb begin
        // Perform operation based on the do_sub control signal
        if (do_sub == 1'b0) begin
            out = a + b;          // Addition
        end else begin
            out = a - b;          // Subtraction
        end

        // Check if the result is zero
        if (out == 8'b00000000) begin
            result_is_zero = 1'b1; // Set zero flag if result is zero
        end else begin
            result_is_zero = 1'b0; // Clear zero flag otherwise
        end
    end

endmodule
```