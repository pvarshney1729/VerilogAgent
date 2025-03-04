```verilog
module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    // Initialize q at startup
    initial begin
        q = 1'b0;
    end

    // Sequential logic on positive clock edge
    always @(posedge clk) begin
        if (a == 1'b0) begin
            q <= 1'b1;
        end else begin
            q <= 1'b0;
        end
    end

endmodule
```