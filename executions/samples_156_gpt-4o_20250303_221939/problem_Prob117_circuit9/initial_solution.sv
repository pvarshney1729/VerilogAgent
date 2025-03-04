```verilog
module TopModule (
    input logic clk,       // Clock signal; positive edge-triggered
    input logic a,         // Input signal 'a'
    output logic [2:0] q   // 3-bit output register 'q'; MSB is q[2], LSB is q[0]
);

    always_ff @(posedge clk) begin
        if (a == 1'b0) begin
            q <= q + 1;
        end else if (a == 1'b1 && q == 3'b000) begin
            q <= 3'b100;
        end
    end

endmodule
```