```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    logic [7:0] prev_in;

    always @(posedge clk) begin
        if (!rst_n) begin
            anyedge <= 8'b0;
            prev_in <= in;
        end else begin
            anyedge <= (in ^ prev_in);
            prev_in <= in;
        end
    end

endmodule
[DONE]
```