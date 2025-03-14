```verilog
[BEGIN]
module TopModule (
    input logic clk,                // Clock signal
    input logic reset,              // Active high reset signal
    input logic load,               // Active high load signal
    input logic enable_shift,       // Active high enable signal for shifting
    input logic [1:0] amount,       // 2-bit signal to select shift operation
    input logic [63:0] data,        // 64-bit input data for loading the register
    output logic [63:0] q           // 64-bit output for the contents of the shift register
);

always @(posedge clk) begin
    if (reset) begin
        q <= 64'b0;                 // Reset state: clear the shift register
    end else if (load) begin
        q <= data;                  // Load data into the register
    end else if (enable_shift) begin
        case (amount)
            2'b00: q <= {q[62:0], 1'b0}; // Shift left by 1 bit
            2'b01: q <= {q[55:0], 8'b0}; // Shift left by 8 bits
            2'b10: q <= {q[63], q[62:1]}; // Arithmetic shift right by 1 bit
            2'b11: q <= {q[63], q[63:8]}; // Arithmetic shift right by 8 bits
            default: q <= q;            // No operation
        endcase
    end
end

endmodule
[DONE]
```