module TopModule(
    input wire           clk,        // Clock signal, active edge not specified
    input wire           load,       // Active-high synchronous load signal
    input wire [1:0]     ena,        // 2-bit control signal for rotation direction
    input wire [99:0]    data,       // 100-bit input data
    output reg [99:0]    q           // 100-bit output data
);

    // Initial state of q
    initial begin
        q = 100'b0;
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]};  // Rotate right by one bit
                2'b10: q <= {q[98:0], q[99]}; // Rotate left by one bit
                default: q <= q;              // No rotation
            endcase
        end
    end

endmodule