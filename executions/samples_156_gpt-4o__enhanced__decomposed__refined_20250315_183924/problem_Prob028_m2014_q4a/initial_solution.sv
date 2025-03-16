```verilog
module TopModule (
    input wire d,      // Data input (unsigned, 1-bit)
    input wire ena,    // Enable signal (unsigned, 1-bit)
    output reg q       // Output (unsigned, 1-bit)
);

always @(*) begin
    if (ena) begin
        q = d; // Pass data to output when enabled
    end
    // Output remains unchanged when ena is low
end

endmodule
```