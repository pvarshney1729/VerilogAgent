```verilog
module TopModule (
    input wire clk,
    input wire rst_n, // Active-low synchronous reset
    input wire j,
    input wire k,
    output reg Q
);

always @(posedge clk) begin
    if (!rst_n) begin
        Q <= 1'b0; // Reset state
    end else begin
        case ({j, k})
            2'b00: Q <= Q;     // No change
            2'b01: Q <= 1'b0;  // Reset to 0
            2'b10: Q <= 1'b1;  // Set to 1
            2'b11: Q <= ~Q;    // Toggle
        endcase
    end
end

endmodule
```