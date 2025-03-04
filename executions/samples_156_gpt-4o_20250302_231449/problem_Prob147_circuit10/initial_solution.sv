module TopModule (
    input logic clk,   // Clock input, positive edge triggered
    input logic a,     // 1-bit input
    input logic b,     // 1-bit input
    output logic q,    // 1-bit output
    output logic state // 1-bit output representing the state of the flip-flop
);

    // Initial state
    initial begin
        q = 1'b0;
        state = 1'b0;
    end

    // Sequential logic
    always_ff @(posedge clk) begin
        if (a == 1'b0 && b == 1'b1) begin
            q <= 1'b1;
        end else begin
            q <= state ^ b;
        end
        state <= q;
    end

endmodule