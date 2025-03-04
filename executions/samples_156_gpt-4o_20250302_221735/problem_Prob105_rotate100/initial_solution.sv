module TopModule (
    input logic clk,            // Clock signal, positive edge triggered
    input logic load,           // Synchronous active-high load signal
    input logic [1:0] ena,      // 2-bit enable for rotation direction
    input logic [99:0] data,    // 100-bit input data, MSB: data[99], LSB: data[0]
    output logic [99:0] q       // 100-bit output data, MSB: q[99], LSB: q[0]
);

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]};  // Rotate right
                2'b10: q <= {q[98:0], q[99]}; // Rotate left
                default: q <= q;              // No rotation
            endcase
        end
    end

endmodule