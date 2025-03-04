module TopModule (
    input logic clk,                    // Clock signal
    input logic load,                   // Synchronous active high load signal
    input logic [1:0] ena,              // Synchronous 2-bit enable signal
    input logic [99:0] data,            // 100-bit input data, unsigned
    output logic [99:0] q               // 100-bit output, reflects rotator content
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        case (ena)
            2'b01: q <= {q[0], q[99:1]};    // Right rotate
            2'b10: q <= {q[98:0], q[99]};   // Left rotate
            default: q <= q;                // No operation
        endcase
    end
end

endmodule