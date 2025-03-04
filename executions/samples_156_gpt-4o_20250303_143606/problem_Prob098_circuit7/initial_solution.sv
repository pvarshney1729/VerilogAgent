```verilog
module TopModule (
    input wire clk,
    input wire a,
    output reg q
);

    // Initial state of q
    initial begin
        q = 1'b0;
    end

    // Sequential logic
    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= ~q; // Toggle q
        end
    end

endmodule
```