```verilog
[BEGIN]
module TopModule (
    input logic in,
    output logic out
);

    always @(*) begin
        out = in; // Combinational logic reflecting input to output
    end

endmodule
[DONE]
```