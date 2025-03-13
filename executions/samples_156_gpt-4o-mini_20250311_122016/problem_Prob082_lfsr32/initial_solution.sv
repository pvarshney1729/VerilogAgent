[BEGIN]
module TopModule (
    input logic clk,            // Clock signal, positive edge triggered
    input logic reset,          // Active high, synchronous reset
    output logic [31:0] q       // 32-bit LFSR output
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h00000001; // Reset state
        end else begin
            q <= {q[30:0], (q[31] ^ q[21] ^ q[1] ^ q[0])}; // Shift-right with feedback
        end
    end

endmodule
[DONE]