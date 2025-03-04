```verilog
module TopModule (
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[0] <= 0 ^ q[1]; // q[-1] = 0
            for (int i = 1; i < 511; i++) begin
                q[i] <= q[i-1] ^ q[i+1];
            end
            q[511] <= q[510] ^ 0; // q[512] = 0
        end
    end

endmodule
```