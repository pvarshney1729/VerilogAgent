[BEGIN]
```verilog
module TopModule (
    input  logic [7:0] data_in,  // 8-bit input data (unsigned)
    input  logic clk,             // Clock for synchronous reset
    input  logic rst,             // Synchronous reset
    output logic parity           // 1-bit output for even parity
);

always @(posedge clk) begin
    if (rst) begin
        parity <= 1'b0; // Reset parity to 0
    end else begin
        parity <= ~(data_in[0] ^ data_in[1] ^ data_in[2] ^ data_in[3] ^
                     data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7]);
    end
end

endmodule
```
[DONE]