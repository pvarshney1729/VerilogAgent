```
[BEGIN]
module TopModule (
    input logic clk,
    input logic rst_n,
    input logic d,
    output logic q
);

    always_ff @(posedge clk) begin
        if (!rst_n)
            q <= 1'b0;  // Reset to 0
        else
            q <= d;     // Capture data on rising edge of clk
    end

endmodule
[DONE]
```