[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [31:0] in,
    output logic [31:0] out
);

    logic [31:0] previous_in;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            previous_in <= 32'b0;
        end else begin
            previous_in <= in;
            out <= out | (previous_in & ~in);
        end
    end

endmodule
```
[DONE]