module TopModule (
    input logic clk,             // Clock signal, active on positive edge
    input logic reset,           // Active-high synchronous reset
    output logic [31:0] q        // 32-bit output, unsigned
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {q[30:0], q[0] ? (q[31] ^ q[21] ^ q[1] ^ 1'b1) : 1'b0};
        end
    end

endmodule