module TopModule (
    input  wire        clk,          // Clock signal, positive edge triggered
    input  wire        load,         // Active high load signal, synchronous
    input  wire [1:0]  ena,          // 2-bit enable signal for rotation direction
    input  wire [99:0] data,         // 100-bit data input
    output reg  [99:0] q             // 100-bit output, stores the state of the rotator
);

    always @(posedge clk) begin
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