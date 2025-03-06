```verilog
module TopModule (
    input  logic [99:0] in,  // 100-bit wide input bus, bit 0 is LSB
    output logic [99:0] out  // 100-bit wide output bus, bit 0 is LSB
);

    always @(*) begin
        integer i;
        for (i = 0; i < 100; i = i + 1) begin
            out[i] = in[99 - i];  // Reverse bit order
        end
    end

endmodule
```