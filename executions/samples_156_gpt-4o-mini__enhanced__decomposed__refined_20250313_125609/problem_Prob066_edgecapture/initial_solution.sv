```
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [31:0] in,
    output logic [31:0] out = 32'b0
);

always @(posedge clk) begin
    if (reset) begin
        out <= 32'b0;
    end else begin
        out <= out | (~in & (in_prev ^ in)); // Capture transitions from 1 to 0
    end
end

logic [31:0] in_prev;

always @(posedge clk) begin
    if (reset) begin
        in_prev <= 32'b0;
    end else begin
        in_prev <= in; // Store previous state of in
    end
end

endmodule
[DONE]
```