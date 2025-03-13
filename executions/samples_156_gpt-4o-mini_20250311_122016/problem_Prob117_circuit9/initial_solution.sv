```
[BEGIN]
module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    always_ff @(posedge clk) begin
        if (a == 1'b0) begin
            if (q == 3'b111)
                q <= 3'b000;
            else
                q <= q + 1;
        end
    end

    initial begin
        q = 3'b000;
    end

endmodule
[DONE]
```