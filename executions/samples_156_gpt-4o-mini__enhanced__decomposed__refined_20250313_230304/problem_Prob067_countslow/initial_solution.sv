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
        q <= 4'b0000;
    end else if (slowena && q < 4'd9) begin
        q <= q + 4'b0001;
    end
end

endmodule
[DONE]
```