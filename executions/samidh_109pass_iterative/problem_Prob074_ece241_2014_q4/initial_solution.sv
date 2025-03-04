module TopModule (
    input logic clk,  // Clock signal, positive edge-triggered for sequential logic
    input logic reset, // Asynchronous reset signal
    input logic x,    // 1-bit input signal
    output logic z    // 1-bit output signal
);

logic FF_XOR, FF_AND, FF_OR;

always_ff @(posedge clk) begin
    if (reset) begin
        FF_XOR <= 1'b0;
        FF_AND <= 1'b0;
        FF_OR <= 1'b0;
    end else begin
        FF_XOR <= x ^ FF_XOR;
        FF_AND <= x & ~FF_AND;
        FF_OR <= x | ~FF_OR;
    end
end

assign z = ~(FF_XOR | FF_AND | FF_OR);

endmodule