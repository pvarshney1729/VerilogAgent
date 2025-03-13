```
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001; // Initial state on reset
    end else begin
        q <= {q[3:0], q[4] ^ q[2]}; // Shift right with feedback
    end
end

endmodule
[DONE]
```