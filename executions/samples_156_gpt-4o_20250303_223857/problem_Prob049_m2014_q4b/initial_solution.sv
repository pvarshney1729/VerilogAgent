module TopModule (
    input wire clk,   // Clock signal, positive edge triggered
    input wire ar,    // Asynchronous reset signal, active high
    input wire d,     // Data input
    output reg q      // Data output (register type for sequential logic)
);

always @(posedge clk or posedge ar) begin
    if (ar) begin
        q <= 1'b0;  // Reset output to '0'
    end else begin
        q <= d;     // Capture input data on rising edge of clock
    end
end

endmodule