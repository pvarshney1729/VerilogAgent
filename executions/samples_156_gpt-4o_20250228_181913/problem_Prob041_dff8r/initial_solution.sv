```verilog
module TopModule (
    input logic clk,           // Clock signal, positive edge-triggered
    input logic reset,         // Active high synchronous reset
    input logic [7:0] d,       // 8-bit input data
    output logic [7:0] q       // 8-bit output data
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000;
        end else begin
            q <= d;
        end
    end

endmodule
```