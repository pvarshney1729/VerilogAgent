```
[BEGIN]
module TopModule (
    output logic out  // Single-bit output
);

    // Combinational logic to drive the output low
    always @(*) begin
        out = 1'b0; // Assign constant low
    end

endmodule
[DONE]
```