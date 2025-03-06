```verilog
module TopModule (
    input logic x,  // 1-bit input, unsigned
    input logic y,  // 1-bit input, unsigned
    output logic z  // 1-bit output, unsigned
);

    always @(*) begin
        z = (x ^ y) & x; // Boolean function
    end

endmodule
```