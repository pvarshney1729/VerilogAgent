```verilog
module TopModule (
    input logic x,  // 1-bit wide, input signal x
    input logic y,  // 1-bit wide, input signal y
    output logic z  // 1-bit wide, output signal z
);

    always @(*) begin
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b10: z = 0;
            2'b11: z = 1;
            default: z = 0; // Default fallback
        endcase
    end

endmodule
```