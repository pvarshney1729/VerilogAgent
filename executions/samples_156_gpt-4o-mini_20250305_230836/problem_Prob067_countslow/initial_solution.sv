```verilog
module TopModule (
    logic clk,
    logic reset,
    logic slowena,
    logic [3:0] q
);

logic [3:0] next_q;

always @(*) begin
    if (reset) begin
        next_q = 4'b0000;
    end else if (slowena) begin
        if (q == 4'b1001) begin
            next_q = 4'b0000;
        end else begin
            next_q = q + 4'b0001;
        end
    end else begin
        next_q = q;
    end
end

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000;
    end else begin
        q <= next_q;
    end
end

endmodule
```