```
[BEGIN]
module TopModule (
    input logic clk,
    input logic [7:0] d,
    output logic [7:0] q
);

    always @(posedge clk) begin
        q <= d; // Store d into q on the positive edge of clk
    end

endmodule
[DONE]
```