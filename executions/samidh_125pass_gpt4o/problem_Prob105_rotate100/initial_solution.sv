module TopModule (
    input wire clk,            // Clock signal, positive edge-triggered
    input wire load,           // Synchronous active-high load signal
    input wire [1:0] ena,      // Synchronous 2-bit enable signal
    input wire [99:0] data,    // 100-bit input data, data[99] is MSB
    output reg [99:0] q        // 100-bit output, q[99] is MSB
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]};  // Rotate right
                2'b10: q <= {q[98:0], q[99]}; // Rotate left
                default: q <= q;              // No operation
            endcase
        end
    end

endmodule