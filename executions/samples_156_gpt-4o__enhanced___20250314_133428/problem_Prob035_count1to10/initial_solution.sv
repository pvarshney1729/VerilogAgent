```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001; // Reset the counter to 1
        end else if (q == 4'b1010) begin
            q <= 4'b0001; // Wrap from 10 to 1
        end else begin
            q <= q + 1'b1; // Increment the counter
        end
    end

endmodule
```