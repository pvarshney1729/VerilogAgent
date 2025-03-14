[BEGIN]
```verilog
module TopModule (
    input logic clk,           // Clock input (active on rising edge)
    input logic a,            // Input signal (1 bit)
    output logic [2:0] q      // Output signal (3 bits, q[0] is LSB, q[2] is MSB)
);

logic reset; // Define reset as a logic type

always @(posedge clk) begin
    if (reset) begin
        q <= 3'b000;  // Reset state
    end else if (a) begin
        q <= (q == 3'b111) ? 3'b000 : q + 1;  // Increment with wrap-around
    end
    // If a is 0, q retains its state
end

endmodule
```
[DONE]