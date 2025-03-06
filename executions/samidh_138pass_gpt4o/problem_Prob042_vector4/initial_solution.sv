```verilog
module TopModule(
    input logic [7:0] in,
    output logic [31:0] out
);

    always @(*) begin
        out = {{24'b0, in[7]}, in}; // Ensure sign extension with explicit size
    end

endmodule
```