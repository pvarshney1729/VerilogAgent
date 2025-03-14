[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [31:0] in,
    output logic [31:0] out
);

    logic [31:0] prev_in;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            prev_in <= 32'b0;
        end else begin
            prev_in <= in;
            out <= (prev_in == 32'b1) && (in == 32'b0) ? 32'b1 : out;
        end
    end

endmodule
```
[DONE]