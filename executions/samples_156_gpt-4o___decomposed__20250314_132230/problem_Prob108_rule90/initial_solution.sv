```verilog
module TopModule(
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

always_ff @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q[0] <= q[1]; // q[-1] assumed as 0
        q[511] <= q[510]; // q[512] assumed as 0
        for (int i = 1; i < 511; i++) begin
            q[i] <= q[i-1] ^ q[i+1];
        end
    end
end

endmodule
```