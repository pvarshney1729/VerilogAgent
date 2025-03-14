module TopModule (
    input logic clk,               // Clock signal, 1 bit
    input logic load,              // Load signal, 1 bit, synchronous active high
    input logic [1:0] ena,         // Enable signal for rotation, 2 bits
    input logic [99:0] data,       // Data input, 100 bits
    output logic [99:0] q          // Output register, 100 bits
);

always @(posedge clk) begin
    if (!load) begin
        case (ena)
            2'b01: q <= {q[0], q[99:1]}; // Rotate right
            2'b10: q <= {q[98:0], q[99]}; // Rotate left
            default: q <= q; // No rotation
        endcase
    end else begin
        q <= data; // Load data into q
    end
end

endmodule