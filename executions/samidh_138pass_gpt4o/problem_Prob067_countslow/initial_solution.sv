```verilog
[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    input logic slowena,
    output logic [3:0] q
);

    // Initial state of the counter
    initial begin
        q = 4'b0000;
    end

    // Sequential logic for the decade counter
    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Synchronous reset
        end else if (slowena) begin
            if (q == 4'b1001) begin
                q <= 4'b0000; // Wrap around after reaching 9
            end else begin
                q <= q + 4'b0001; // Increment counter
            end
        end
    end

endmodule
[DONE]
```