```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    always_ff @(negedge clk) begin
        if (reset) begin
            q <= 8'b00110100; // Initialize q to 0x34 on reset
        end else begin
            q <= d; // Transfer input d to output q
        end
    end

endmodule
```