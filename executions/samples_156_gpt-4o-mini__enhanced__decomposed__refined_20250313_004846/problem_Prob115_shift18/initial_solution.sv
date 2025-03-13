```
[BEGIN]
module TopModule(
    input logic clk,             // Clock signal
    input logic load,            // Load enable signal, active high
    input logic ena,             // Shift enable signal, active high
    input logic [1:0] amount,    // Shift amount and direction control
    input logic [63:0] data,     // Data input for loading
    output logic [63:0] q         // Shift register output
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else if (ena) begin
        case (amount)
            2'b00: q <= q << 1;                           // Shift left by 1
            2'b01: q <= q << 8;                           // Shift left by 8
            2'b10: q <= {q[63], q[63:1]};                 // Arithmetic shift right by 1
            2'b11: q <= {{8{q[63]}}, q[63:8]};            // Arithmetic shift right by 8
            default: q <= q;                              // Default case (no operation)
        endcase
    end
end

endmodule
[DONE]
```