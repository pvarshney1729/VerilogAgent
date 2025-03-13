module TopModule (
    input logic do_sub,
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] out,
    output logic result_is_zero
);

    initial begin
        out = 8'b0;                  // Initialize output to zero
        result_is_zero = 1'b0;      // Initialize zero flag to false
    end

    always @(*) begin
        // Perform addition or subtraction based on the control signal
        if (do_sub == 1'b0) begin
            out = a + b;             // Perform addition
        end else begin
            out = a - b;             // Perform subtraction
        end

        // Set the zero flag based on the output
        if (out == 8'b0) begin
            result_is_zero = 1'b1;   // Set zero flag if output is zero
        end else begin
            result_is_zero = 1'b0;   // Clear zero flag otherwise
        end
    end

endmodule