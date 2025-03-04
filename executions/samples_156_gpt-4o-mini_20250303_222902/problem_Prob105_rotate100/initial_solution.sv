module TopModule (
    input logic clk,           // Clock signal; operations occur on the rising edge.
    input logic load,         // Synchronous active-high load signal.
    input logic [1:0] ena,    // Enable signal to control rotation direction.
    input logic [99:0] data,   // 100-bit data bus for loading the shift register.
    output logic [99:0] q      // 100-bit output representing the current state of the rotator.
);

    // Synchronous reset and initial state
    always @(posedge clk) begin
        if (load) begin
            q <= data;         // Load data into q
        end else begin
            case (ena)
                2'b01: q <= {q[98:0], q[99]}; // Rotate right
                2'b10: q <= {q[0], q[99:1]};  // Rotate left
                default: q <= q;              // Maintain current state
            endcase
        end
    end

    // Initialize q to zero in simulation
    initial begin
        q = 100'b0; // Initial state
    end

endmodule