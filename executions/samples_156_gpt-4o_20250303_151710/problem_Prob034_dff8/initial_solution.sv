```verilog
module TopModule (
    input logic clk,
    input logic [7:0] d,
    output logic [7:0] q,
    input logic rst_n
);

    always @(posedge clk) begin
        if (!rst_n) begin
            q <= 8'b00000000;
        end else begin
            q <= d;
        end
    end

endmodule
```