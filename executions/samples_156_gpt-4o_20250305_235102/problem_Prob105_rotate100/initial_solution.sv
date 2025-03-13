module TopModule (
    input logic clk,                 // System clock signal
    input logic load,                // Active-high synchronous load signal
    input logic [1:0] ena,           // 2-bit synchronous enable signal for rotation
    input logic [99:0] data,         // 100-bit input data vector
    output logic [99:0] q            // 100-bit output data vector
);

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]};  // Rotate right by one bit
                2'b10: q <= {q[98:0], q[99]}; // Rotate left by one bit
                default: q <= q;              // Maintain current state
            endcase
        end
    end

endmodule