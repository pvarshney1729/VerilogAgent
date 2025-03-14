```verilog
module TopModule (
    input logic clk,  // Clock signal, positive edge-triggered
    input logic a,    // 1-bit input signal
    output logic q    // 1-bit output signal
);

    always @(posedge clk) begin
        if (a == 1'b0) begin
            q <= 1'b1;
        end else begin
            q <= ~q;
        end
    end

endmodule
```