```verilog
module TopModule (
    input logic d,     // Unsigned 1-bit data input
    input logic ena,   // Unsigned 1-bit enable input
    output logic q     // Unsigned 1-bit data output, logic type
);

    initial begin
        q = 1'b0; // Initial state of q
    end

    always @(*) begin
        if (ena) begin
            q = d;  // Latch 'd' when 'ena' is high
        end
    end

endmodule
```