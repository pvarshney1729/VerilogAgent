```verilog
module TopModule (
    input wire clk,            // Clock signal, active on positive edge
    input wire reset,          // Active high synchronous reset
    input wire [7:0] d,        // 8-bit input data bus (unsigned)
    output reg [7:0] q         // 8-bit output data bus (unsigned)
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000;  // Synchronous reset sets q to 0
        end else begin
            q <= d;            // Capture input d into q
        end
    end

endmodule
```