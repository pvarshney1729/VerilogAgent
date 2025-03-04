```verilog
module TopModule (
    input logic do_sub,             // Operation selector: 0 for addition, 1 for subtraction
    input logic [7:0] a,            // 8-bit unsigned input operand A
    input logic [7:0] b,            // 8-bit unsigned input operand B
    output logic [7:0] out,         // 8-bit unsigned output result
    output logic result_is_zero     // Zero flag output
);

    // Combinational logic for adder-subtractor with zero flag
    always @(*) begin
        case (do_sub)
            1'b0: out = a + b;      // Perform addition when do_sub is 0
            1'b1: out = a - b;      // Perform subtraction when do_sub is 1
            default: out = 8'hXX;   // Undefined operation for other values of do_sub
        endcase

        // Set zero flag if the output is zero
        result_is_zero = (out == 8'b0);
    end

endmodule
```