[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic a,
    output logic q
);
    logic state;

    always @(posedge clk) begin
        if (a == 1'b1 && state == 1'b0) begin
            state <= 1'b1;
        end else if (a == 1'b0 && state == 1'b1) begin
            state <= 1'b0;
        end
    end

    assign q = state;

endmodule
```
[DONE]