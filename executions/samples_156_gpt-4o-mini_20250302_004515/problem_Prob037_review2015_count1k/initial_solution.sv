```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 10'b0000000000;
        end else begin
            if (q == 10'b1111100111) begin
                q <= 10'b0000000000;
            end else begin
                q <= q + 1;
            end
        end
    end

endmodule
```