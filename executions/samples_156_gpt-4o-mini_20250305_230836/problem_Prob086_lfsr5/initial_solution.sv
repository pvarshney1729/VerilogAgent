```verilog
[BEGIN]
module TopModule(
    logic clk,
    logic reset,
    logic [4:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001;
    end else begin
        q <= {q[3:0], q[4] ^ q[2]};
    end
end

endmodule
[DONE]
```