module TopModule(
    input logic clk,
    input logic x,
    output logic z
);

    // Internal signals for flip-flop outputs
    logic FF1_Q, FF2_Q, FF3_Q;

    // Combinational logic
    logic XOR_out, AND_out, OR_out;

    always @(*) begin
        XOR_out = x ^ FF1_Q;
        AND_out = x & ~FF2_Q;
        OR_out = x | ~FF3_Q;
    end

    // Sequential logic with synchronous reset
    always_ff @(posedge clk) begin
        FF1_Q <= XOR_out;
        FF2_Q <= AND_out;
        FF3_Q <= OR_out;
    end

    // Output logic
    assign z = ~(FF1_Q | FF2_Q | FF3_Q);

endmodule