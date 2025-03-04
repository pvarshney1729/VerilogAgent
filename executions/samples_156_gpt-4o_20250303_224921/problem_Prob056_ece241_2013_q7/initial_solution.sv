```verilog
module TopModule(
    input clk,
    input j,
    input k,
    input reset_n,
    output reg Q
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        Q <= 1'b0;  // Asynchronous reset to 0
    else begin
        case ({j, k})
            2'b00: Q <= Q;      // No change
            2'b01: Q <= 1'b0;   // Reset
            2'b10: Q <= 1'b1;   // Set
            2'b11: Q <= ~Q;     // Toggle
        endcase
    end
end

endmodule
```