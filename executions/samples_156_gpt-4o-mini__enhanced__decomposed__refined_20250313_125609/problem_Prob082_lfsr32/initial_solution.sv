[BEGIN]
```verilog
module TopModule (
    input  logic clk,            // Clock input (positive edge-triggered)
    input  logic reset,          // Active high synchronous reset
    output logic [31:0] q        // 32-bit output (unsigned)
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;          // Reset to 32'h1
        end else begin
            logic new_lsb;      // Intermediate signal for new LSB
            new_lsb = q[1] ^ q[2] ^ q[22] ^ q[31]; // XOR of tap bits for new LSB
            q <= {new_lsb, q[31:1]}; // Shift right and assign new LSB
        end
    end
endmodule
```
[DONE]