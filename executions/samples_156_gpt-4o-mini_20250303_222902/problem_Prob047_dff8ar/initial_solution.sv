module TopModule (
    input logic clk,       // Clock signal, positive edge-triggered
    input logic areset,    // Asynchronous reset, active high
    input logic [7:0] d,   // 8-bit data input, unsigned
    output logic [7:0] q    // 8-bit data output, unsigned
);

always @(*) begin
    if (areset) begin
        q = 8'b00000000; // Reset output to zero
    end else begin
        q = d; // Transfer input to output on clock edge
    end
end

endmodule