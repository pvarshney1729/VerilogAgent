module TopModule(
    input logic clk,          // Positive-edge triggered clock
    input logic reset,        // Active-high synchronous reset
    output logic [4:0] q      // 5-bit output representing the state of the LFSR
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Initialize to state 00001 on reset
        end else begin
            q <= {q[3] ^ q[0], q[4], q[3], q[2] ^ q[0], q[1]};
        end
    end

endmodule