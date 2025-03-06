```verilog
module TopModule (
    input logic [255:0] in,
    input logic [7:0] sel,
    output logic out
);
    always @(*) begin
        out = in[sel]; // Ensure sel is within bounds in practical use
    end
endmodule
```