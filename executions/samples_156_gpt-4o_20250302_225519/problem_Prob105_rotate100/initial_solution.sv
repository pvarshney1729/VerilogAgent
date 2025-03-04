module TopModule (
    input logic clk,                     // Clock signal, active edge not specified
    input logic reset,                   // Synchronous active high reset signal
    input logic load,                    // Synchronous active high load signal
    input logic [1:0] ena,               // 2-bit control signal for rotation direction
    input logic [99:0] data,             // 100-bit input data
    output logic [99:0] q                // 100-bit output data
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 100'b0;                 // Initialize q to all zeros on reset
        end else if (load) begin
            q <= data;                   // Load data into q
        end else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]};  // Rotate right
                2'b10: q <= {q[98:0], q[99]}; // Rotate left
                default: ;                    // Maintain current value
            endcase
        end
    end

endmodule