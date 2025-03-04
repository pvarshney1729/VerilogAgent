```verilog
module TopModule(
    input logic clk,         // Clock signal, positive edge-triggered
    input logic load,        // Synchronous active high load enable
    input logic [1:0] ena,   // Two-bit enable signal for rotation
    input logic [99:0] data, // 100-bit input data, bit 0 is LSB
    output logic [99:0] q    // 100-bit output register, bit 0 is LSB
);

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]}; // Rotate right
                2'b10: q <= {q[98:0], q[99]}; // Rotate left
                default: q <= q; // No operation
            endcase
        end
    end

endmodule
```