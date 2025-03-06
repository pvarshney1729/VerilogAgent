[BEGIN]
```verilog
module TopModule(
    input logic clk,
    input logic rst,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] in_prev;

    always_ff @(posedge clk) begin
        if (rst) begin
            pedge <= 8'b00000000;
            in_prev <= 8'b00000000;
        end else begin
            pedge <= (~in_prev) & in;
            in_prev <= in;
        end
    end

endmodule
```
[DONE]