module TopModule (
    input logic do_sub,       // Control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,      // 8-bit operand a
    input logic [7:0] b,      // 8-bit operand b
    output logic [7:0] out,   // 8-bit result of a+b or a-b
    output logic result_is_zero // Flag indicating if the result is zero
);

    // Combinational logic block
    always @(*) begin
        // Compute the output based on operation mode
        case (do_sub) 
            1'b0: out = a + b;  // Perform unsigned addition
            1'b1: out = a - b;  // Perform unsigned subtraction
        endcase

        // Determine if the result is zero
        result_is_zero = (out == 8'b00000000);
    end

endmodule