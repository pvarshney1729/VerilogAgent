```
[BEGIN]
module TopModule (
    input logic clk,            // Clock signal, positive-edge triggered
    input logic resetn,         // Active-low, synchronous reset
    input logic [1:0] byteena,  // Byte enable, 2 bits
    input logic [15:0] d,       // Data input, 16 bits
    output logic [15:0] q       // Data output, 16 bits
);

    always @(posedge clk) begin
        if (!resetn) begin
            q <= 16'b0; // Synchronous reset to 0
        end else begin
            if (byteena[1]) begin
                q[15:8] <= d[15:8];
            end
            if (byteena[0]) begin
                q[7:0] <= d[7:0];
            end
        end
    end

endmodule
[DONE]
```