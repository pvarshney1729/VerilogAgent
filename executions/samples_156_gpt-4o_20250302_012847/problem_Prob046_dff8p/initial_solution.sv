module d_flip_flop (
    input logic clk,
    input logic reset,
    input logic d,
    output logic q
);

    // Initialize q to an undefined state
    initial begin
        q = 'x;
    end

    // Sequential logic for D flip-flop with synchronous reset
    always_ff @(negedge clk) begin
        if (reset) begin
            q <= 8'h34;
        end else begin
            q <= d;
        end
    end

endmodule