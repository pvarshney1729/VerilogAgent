```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Initialize the counter to 0
    initial begin
        q = 4'b0000;
    end

    // Synchronous decade counter with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset the counter to 0
        end else if (q == 4'b1001) begin
            q <= 4'b0000; // Wrap around when reaching 9
        end else begin
            q <= q + 1; // Increment the counter
        end
    end

endmodule
```