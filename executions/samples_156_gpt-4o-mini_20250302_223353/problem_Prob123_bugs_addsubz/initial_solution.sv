module TopModule (
    input logic do_sub,           // Control signal: 0 for add, 1 for subtract
    input logic [7:0] a,          // 8-bit unsigned operand a
    input logic [7:0] b,          // 8-bit unsigned operand b
    output logic [7:0] out,        // 8-bit unsigned result of the operation
    output logic result_is_zero    // Flag indicating if the result is zero
);

    // Combinational logic block: Calculate the result based on do_sub
    always @(*) begin
        if (do_sub == 1'b0) begin
            out = a + b;         // Perform addition when do_sub is 0
        end else begin
            out = a - b;         // Perform subtraction when do_sub is 1
        end

        // Determine if the result is zero
        result_is_zero = (out == 8'b0) ? 1'b1 : 1'b0;
    end

endmodule