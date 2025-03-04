```verilog
module TopModule(
    input logic clk,
    input logic a,
    input logic reset,
    output logic q
);

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 1'b0;
    end else begin
        if (a == 1'b1) begin
            q <= ~q;
        end
        // If a == 0, q retains its value
    end
end

endmodule
```