```verilog
module TopModule (
    input logic clk,                  // Clock signal, active on rising edge
    input logic load,                 // Load signal, active high
    input logic ena,                  // Enable signal, active high
    input logic [1:0] amount,         // 2-bit control signal for shift direction and magnitude
    input logic [63:0] data,          // 64-bit input data
    output logic [63:0] q             // 64-bit output register
);

always @(posedge clk) begin
    if (load) begin
        q <= data;  // Load operation
    end else if (ena) begin
        case (amount)
            2'b00: q <= {q[62:0], 1'b0};                // Shift left by 1 bit
            2'b01: q <= {q[55:0], 8'b0};                // Shift left by 8 bits
            2'b10: q <= {q[63], q[63:1]};               // Arithmetic shift right by 1 bit
            2'b11: q <= {{8{q[63]}}, q[63:8]};          // Arithmetic shift right by 8 bits
            default: q <= q;                            // Default case to hold the value
        endcase
    end
end

endmodule
```