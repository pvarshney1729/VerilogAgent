module TopModule (
    input wire clk,            // Clock signal, positive edge-triggered
    input wire reset,          // Synchronous active-high reset
    output reg [31:0] q        // 32-bit output, representing the LFSR state
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // Initial value on reset
        end else begin
            q <= {q[0] ^ q[31], q[31:22], q[0] ^ q[21], q[20:2], q[0] ^ q[1], q[0]};
        end
    end

endmodule