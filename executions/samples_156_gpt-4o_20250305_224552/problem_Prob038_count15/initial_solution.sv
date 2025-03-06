```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Initial block to define the initial state of the counter
    initial begin
        q = 4'b0000; // Initialize the counter to 0
    end

    // Always block to define the counter's behavior
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset counter to 0
        end else begin
            q <= q + 1'b1; // Increment counter
        end
    end
endmodule
```