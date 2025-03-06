```verilog
module TopModule (
    input logic clk,                 // Clock signal, positive edge-triggered
    input logic reset,               // Active high synchronous reset
    input logic [7:0] d,             // 8-bit input data vector (unsigned)
    output logic [7:0] q             // 8-bit output data vector (unsigned)
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000;        // Synchronous reset, set output to zero
        end else begin
            q <= d;                  // Load input data into output
        end
    end

endmodule
```