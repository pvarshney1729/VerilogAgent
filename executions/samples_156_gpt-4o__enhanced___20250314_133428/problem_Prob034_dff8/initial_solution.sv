```verilog
module TopModule (
    input logic clk,
    input logic [7:0] d,
    input logic reset,
    output logic [7:0] q
);
    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000; // Reset state
        end else begin
            q <= d; // Latch data input to output
        end
    end
endmodule
```