```
[BEGIN]
module TopModule (
    input logic clk,            // Clock signal, active on the rising edge.
    input logic load,           // Load signal, active high, used to load initial data.
    input logic [511:0] data,   // 512-bit input data, unsigned.
    output logic [511:0] q       // 512-bit output register, unsigned.
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[0] <= 1'b0 ^ data[1]; // q[-1] assumed to be 0
            q[511] <= data[510] ^ 1'b0; // q[512] assumed to be 0
            for (integer i = 1; i < 511; i = i + 1) begin
                q[i] <= data[i-1] ^ data[i+1];
            end
        end
    end

endmodule
[DONE]
```