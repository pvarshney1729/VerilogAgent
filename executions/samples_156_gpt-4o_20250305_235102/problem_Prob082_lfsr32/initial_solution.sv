```verilog
[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    output logic [31:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 32'b00000000000000000000000000000001; // Use explicit size for numeric constant
        end else begin
            q <= {q[30:0], (q[0] ^ q[1] ^ q[21] ^ q[31])};
        end
    end

endmodule
[DONE]
```