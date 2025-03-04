```verilog
module TopModule (
    input logic clk,         // Clock signal, positive edge-triggered
    input logic rst,         // Active-high synchronous reset
    input logic [7:0] d,     // Data input bus, 8 bits wide
    output logic [7:0] q     // Data output bus, 8 bits wide
);

    // Sequential logic for D-type flip-flops with synchronous reset
    always_ff @(posedge clk) begin
        if (rst) begin
            q <= 8'b00000000; // Reset q to all zeros
        end else begin
            q <= d;           // Transfer input d to output q
        end
    end

endmodule
```