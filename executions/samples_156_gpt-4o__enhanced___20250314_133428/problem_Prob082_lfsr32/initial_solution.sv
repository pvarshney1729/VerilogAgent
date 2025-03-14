```verilog
module TopModule (
    input  logic clk,          // Clock input, positive-edge triggered
    input  logic reset,        // Active high, synchronous reset
    output logic [31:0] q      // 32-bit output for the LFSR state
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {q[30:0], q[0] ^ q[31] ^ q[21] ^ q[1]};
        end
    end

endmodule
```