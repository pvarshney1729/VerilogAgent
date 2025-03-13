```verilog
[BEGIN]
module TopModule(
    input  logic [3:0] x,
    output logic       f
);

    always @(*) begin
        f = (1'b0 & 1'b1 & 1'b1 & 1'b1) |
            (1'b0 & 1'b1 & 1'b0 & 1'b0) |
            (1'b1 & 1'b1 & 1'b1 & 1'b0) |
            (1'b1 & 1'b1 & 1'b0 & 1'b1) |
            (1'b1 & 1'b1 & 1'b1 & 1'b0) |
            (1'b0 & 1'b1 & 1'b1 & 1'b1) |
            (1'b0 & 1'b1 & 1'b0 & 1'b1);
    end

endmodule
[DONE]
```