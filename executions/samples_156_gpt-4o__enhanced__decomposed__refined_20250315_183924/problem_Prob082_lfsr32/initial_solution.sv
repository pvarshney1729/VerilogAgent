```verilog
module TopModule (
    input logic clk,         // Clock signal, positive edge triggered
    input logic reset,       // Active high synchronous reset
    output logic [31:0] q    // 32-bit output, unsigned
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;  // Reset state
        end else begin
            // LFSR Galois operation
            q <= {q[30:0], q[0] ^ q[31] ^ q[21] ^ q[1]}; // Shift right with XOR taps
        end
    end

endmodule
```