module TopModule (
    input logic clk,          // Clock signal (1 bit, positive edge triggered)
    input logic reset,        // Reset signal (1 bit, active high, synchronous)
    input logic [7:0] d,      // Input data (8 bits, d[0] is LSB, d[7] is MSB)
    output logic [7:0] q       // Output data (8 bits, q[0] is LSB, q[7] is MSB)
);

always @(posedge clk) begin
    if (reset) begin
        q <= 8'b00000000; // On reset, set output q to zero.
    end else begin
        q <= d; // On clock edge, transfer input d to output q.
    end
end

endmodule