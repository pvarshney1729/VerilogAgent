```verilog
module TopModule(
    input logic clk,
    input logic a,
    output logic q
);
    always_ff @(posedge clk) begin
        if (a) begin
            q <= ~q;
        end
        // Else maintain current state
    end
endmodule
```