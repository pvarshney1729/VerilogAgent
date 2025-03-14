[DONE]
```verilog
module TopModule (
    output logic zero  // 1-bit output port
);
    always @* begin
        zero = 1'b0; // Drive zero output LOW
    end
endmodule
```