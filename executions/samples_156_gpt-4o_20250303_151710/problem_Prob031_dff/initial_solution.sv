```verilog
module TopModule (
    input logic clk,
    input logic reset_n,
    input logic d,
    output logic q
);

// Positive edge-triggered D flip-flop with asynchronous active-low reset
always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        q <= 1'b0; // Asynchronous reset
    end else begin
        q <= d; // Sample data on positive clock edge
    end
end

endmodule
```