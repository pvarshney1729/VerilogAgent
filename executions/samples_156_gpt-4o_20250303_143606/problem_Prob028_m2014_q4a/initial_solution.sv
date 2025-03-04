```verilog
module TopModule (
    input wire d,       // Data input, 1-bit width
    input wire ena,     // Enable input, 1-bit width, active high
    output reg q        // Output, 1-bit width
);

always @(*) begin
    if (ena) begin
        q = d; // Pass the data to output when ena is high
    end
    // No else block, q retains its value when ena is low
end

endmodule
```