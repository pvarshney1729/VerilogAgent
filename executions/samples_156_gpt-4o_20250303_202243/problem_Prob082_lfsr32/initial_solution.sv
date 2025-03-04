module TopModule (
    input wire clk,          // Clock signal, positive edge-triggered.
    input wire reset,        // Active high synchronous reset.
    output reg [31:0] q      // 32-bit output register for LFSR.
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};
        end
    end

endmodule