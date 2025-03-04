```verilog
module TopModule(
    input logic clk,
    input logic a,
    input logic rst_n,
    output logic q
);

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        q <= 1'b0;
    end else if (a) begin
        q <= 1'b0;
    end else begin
        q <= q; // Maintain state if a is 0
    end
end

endmodule
```