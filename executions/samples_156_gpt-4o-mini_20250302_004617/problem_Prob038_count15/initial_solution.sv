```verilog
module counter (
    input logic clk,
    input logic reset,
    output logic [3:0] count
);

    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000; // Synchronous reset
        end else begin
            count <= count + 1'b1; // Increment count with wrap-around
        end
    end

endmodule
```