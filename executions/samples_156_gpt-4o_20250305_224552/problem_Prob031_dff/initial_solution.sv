```verilog
module TopModule (
    input logic clk,
    input logic d,
    input logic rst,
    output logic q
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule
```