```verilog
[BEGIN]
module TopModule(
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    initial begin
        q = 3'b000;  // Initial state
    end

    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100;  // Hold state when a is 1
        end else begin
            q <= (q == 3'b111) ? 3'b000 : q + 1;  // Increment and wrap around
        end
    end

endmodule
[DONE]
```