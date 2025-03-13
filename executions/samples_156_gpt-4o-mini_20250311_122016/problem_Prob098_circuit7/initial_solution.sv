[BEGIN]
```verilog
module TopModule(
    input logic clk,    // Clock signal, positive edge triggered
    input logic a,      // Input signal, 1-bit, interpreted as unsigned
    output logic q      // Output signal, 1-bit, initialized to 0 on reset
);

always_ff @(posedge clk) begin
    if (a == 1'b1 && q == 1'b1) begin
        q <= 1'b0; // Reset q to 0 if a is 1 and q is 1
    end else if (a == 1'b0) begin
        q <= 1'b1; // Set q to 1 if a is 0
    end
end

initial begin
    q = 1'b0; // Initial reset state of q to 0
end

endmodule
```
[DONE]