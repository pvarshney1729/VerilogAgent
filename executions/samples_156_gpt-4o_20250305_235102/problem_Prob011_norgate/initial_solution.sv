```verilog
[BEGIN]
module TopModule (
    input logic a,    // 1-bit input
    input logic b,    // 1-bit input
    output logic out  // 1-bit output
);
    // Implement the NOR gate logic
    always @(*) begin
        out = ~(a | b); // Utilize explicit sizing for numeric constants
    end
endmodule
[DONE]
```