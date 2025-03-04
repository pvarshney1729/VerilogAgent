module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic reset,        // Synchronous active-high reset
    output logic [31:0] q     // 32-bit output, unsigned
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;  // Initial state on reset
        end else begin
            q <= {q[30:0], (q[31] ^ q[21] ^ q[1] ^ q[0])};  // Shift and feedback logic
        end
    end

endmodule