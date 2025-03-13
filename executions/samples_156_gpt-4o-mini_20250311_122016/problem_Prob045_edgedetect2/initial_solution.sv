[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic [7:0] in,
    input logic reset_n,
    output logic [7:0] anyedge
);

    logic [7:0] prev_in;

    always @(posedge clk) begin
        if (!reset_n) begin
            anyedge <= 8'b0;
            prev_in <= 8'b0;
        end else begin
            anyedge <= (in ^ prev_in);
            prev_in <= in;
        end
    end

endmodule
```
[DONE]