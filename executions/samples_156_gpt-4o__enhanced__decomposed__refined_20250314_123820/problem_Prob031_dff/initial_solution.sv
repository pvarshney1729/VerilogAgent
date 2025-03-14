[BEGIN]
module TopModule (
    input logic clk,       // Clock input, positive edge-triggered
    input logic d,         // Data input
    output logic q,        // Data output, representing the stored value
    input logic reset      // Synchronous reset input, active high
);

always @(posedge clk) begin
    if (reset) begin
        q <= 1'b0;  // Synchronous reset to 0
    end else begin
        q <= d;     // Capture 'd' on the rising edge of 'clk'
    end
end

endmodule
[DONE]