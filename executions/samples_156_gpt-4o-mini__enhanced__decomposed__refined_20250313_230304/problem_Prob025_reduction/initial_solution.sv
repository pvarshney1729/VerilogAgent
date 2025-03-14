```verilog
[BEGIN]
module TopModule (
    input  logic [7:0] in,       // 8-bit input data (MSB: in[7], LSB: in[0])
    input  logic clk,            // Clock signal for synchronous reset
    input  logic rst_n,          // Active low reset signal
    output logic parity          // Output parity bit (active high)
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        parity <= 1'b0; // Reset state for parity
    end else begin
        parity <= in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7]; // Even parity calculation
    end
end

endmodule
[DONE]
```