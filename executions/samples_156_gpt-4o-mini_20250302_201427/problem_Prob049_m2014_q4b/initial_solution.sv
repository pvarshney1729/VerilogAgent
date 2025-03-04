module TopModule (
    input  logic clk,           // Clock signal, positive edge-triggered
    input  logic async_reset,   // Asynchronous reset, active high
    input  logic d,             // Data input
    output logic q              // D flip-flop output
);

always @(posedge clk or posedge async_reset) begin
    if (async_reset) begin
        q <= 1'b0;  // Reset state
    end else begin
        q <= d;     // Capture data input
    end
end

endmodule