module TopModule(
    input logic clk,
    input logic d,
    output logic q
);

    logic q_pos, q_neg;

    // Rising edge triggered flip-flop
    always_ff @(posedge clk) begin
        q_pos <= d;
    end

    // Falling edge triggered flip-flop
    always_ff @(negedge clk) begin
        q_neg <= d;
    end

    // Combining logic to simulate dual-edge behavior
    always_comb begin
        q = clk ? q_neg : q_pos;
    end

endmodule