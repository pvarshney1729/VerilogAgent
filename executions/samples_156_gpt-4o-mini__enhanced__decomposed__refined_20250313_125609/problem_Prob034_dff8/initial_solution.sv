[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic [7:0] d,
    input logic reset,          // Added reset input
    output logic [7:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 8'b00000000; // Initialize output q to 0 on reset
    end else begin
        q <= d; // On clock edge, assign input d to output q
    end
end

endmodule
```
[DONE]