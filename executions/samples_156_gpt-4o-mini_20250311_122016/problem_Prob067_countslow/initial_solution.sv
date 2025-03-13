```
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic slowena,
    output logic [3:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset to 0
        end else if (slowena) begin
            if (q == 4'd9) begin
                q <= 4'b0000; // Wrap around to 0
            end else begin
                q <= q + 4'b0001; // Increment counter
            end
        end
    end

endmodule
[DONE]
```