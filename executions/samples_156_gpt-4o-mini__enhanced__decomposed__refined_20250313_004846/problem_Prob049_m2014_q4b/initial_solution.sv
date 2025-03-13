```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic ar,
    input logic d,
    output logic q
);

always @(posedge clk) begin
    if (ar) begin
        q <= 1'b0; // Asynchronous reset, active high, sets q to 0
    end else begin
        q <= d; // Capture data on positive clock edge
    end
end

endmodule
[DONE]
```