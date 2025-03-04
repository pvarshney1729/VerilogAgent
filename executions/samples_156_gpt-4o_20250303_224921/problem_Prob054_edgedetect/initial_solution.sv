```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] in_d;

    always_ff @(posedge clk) begin
        if (reset) begin
            pedge <= 8'b0;
            in_d <= 8'b0;
        end else begin
            pedge <= (in & ~in_d);
            in_d <= in;
        end
    end

endmodule
```