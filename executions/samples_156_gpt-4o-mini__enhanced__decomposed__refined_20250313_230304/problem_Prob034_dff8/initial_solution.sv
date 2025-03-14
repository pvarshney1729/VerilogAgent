```
[BEGIN]
module TopModule (
    input logic clk,
    input logic [7:0] d,
    input logic rst,
    output logic [7:0] q
);
    always @(posedge clk) begin
        if (rst) begin
            q <= 8'b0; // Reset all flip-flops to 0
        end else begin
            q <= d; // Capture input d on rising edge of clk
        end
    end
endmodule
[DONE]
```