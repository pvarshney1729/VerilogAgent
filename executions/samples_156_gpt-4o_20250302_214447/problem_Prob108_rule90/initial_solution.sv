```verilog
module TopModule (
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);
    integer i;

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0)
                    q[i] <= 0 ^ q[i+1];
                else if (i == 511)
                    q[i] <= q[i-1] ^ 0;
                else
                    q[i] <= q[i-1] ^ q[i+1];
            end
        end
    end
endmodule
```