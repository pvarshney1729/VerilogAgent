```
[BEGIN]
module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [7:0] d,
    output logic [7:0] q
);

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q <= 8'b0; // Reset q to 0
        end else begin
            q <= d;
        end
    end

endmodule
[DONE]
```