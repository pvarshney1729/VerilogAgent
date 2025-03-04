```verilog
module TopModule(
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    always_ff @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100;
        end else begin
            if (q == 3'b110) begin
                q <= 3'b000;
            end else begin
                q <= q + 1'b1;
            end
        end
    end
endmodule
```