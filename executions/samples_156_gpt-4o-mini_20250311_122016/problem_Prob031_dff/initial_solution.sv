```
[BEGIN]
module TopModule (
    input logic clk,
    input logic d,
    input logic reset_n,
    output logic q
);
    always @(posedge clk) begin
        if (!reset_n)
            q <= 1'b0; // Reset state
        else
            q <= d; // Update state
    end
endmodule
[DONE]
```