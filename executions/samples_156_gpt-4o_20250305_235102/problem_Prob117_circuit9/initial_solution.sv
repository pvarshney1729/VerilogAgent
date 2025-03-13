```
[BEGIN]
module TopModule (
    input logic clk,
    input logic rst_n,
    input logic a,
    output logic [2:0] q
);

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q <= 3'b000;
        end else if (!a) begin
            q <= q + 3'b001;
        end
    end

endmodule
[DONE]
```