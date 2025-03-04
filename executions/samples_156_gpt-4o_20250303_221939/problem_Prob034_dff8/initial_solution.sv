```verilog
module TopModule (
    input logic clk,              // Clock signal, positive edge-triggered
    input logic rst_n,            // Active-low asynchronous reset
    input logic [7:0] d,          // 8-bit input data bus, unsigned
    output logic [7:0] q          // 8-bit output data bus, unsigned
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 8'b00000000;    // Reset state: all zeros
        else
            q <= d;              // Capture input data on clock edge
    end
endmodule
```