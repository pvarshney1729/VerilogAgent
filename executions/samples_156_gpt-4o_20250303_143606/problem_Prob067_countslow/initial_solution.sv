```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic slowena,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset counter to 0
        end else if (slowena) begin
            if (q == 4'b1001) begin
                q <= 4'b0000; // Wrap-around from 9 to 0
            end else begin
                q <= q + 1'b1; // Increment counter
            end
        end
        // If slowena is low, retain current value of q
    end

endmodule
```