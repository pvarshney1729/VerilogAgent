[BEGIN]
module TopModule (
    input  logic clk,  // Clock signal, single bit
    input  logic ar,   // Asynchronous reset, active high, single bit
    input  logic d,    // Data input for D flip-flop, single bit
    output logic q     // Output of D flip-flop, single bit
);

always_ff @(posedge clk or posedge ar) begin
    if (ar) begin
        q <= 1'b0;  // Reset the output to 0
    end else begin
        q <= d;  // Capture input 'd' at the rising edge of 'clk'
    end
end

endmodule
[DONE]