[BEGIN]
```verilog
module TopModule (
    input logic i_in,    // Single-bit unsigned input
    output logic o_out   // Single-bit unsigned output
);
    always @(*) begin
        o_out = i_in; // Direct connection behaving as a wire
    end
endmodule
```
[DONE]