```verilog
module TopModule (
    input logic clk,
    input logic d_in,
    output logic q_out
);

    always_ff @(posedge clk) begin
        q_out <= d_in;
    end

endmodule
```