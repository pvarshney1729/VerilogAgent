```verilog
module TopModule(
    input logic clk,
    input logic in,
    output logic out
);

    // Initial value for simulation purposes
    initial begin
        out = 1'b0;
    end

    always_ff @(posedge clk) begin
        out <= in ^ out;
    end

endmodule
```