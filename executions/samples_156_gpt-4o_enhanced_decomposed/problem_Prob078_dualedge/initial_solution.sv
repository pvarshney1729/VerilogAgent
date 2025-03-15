module TopModule(
    input logic clk,
    input logic d,
    output logic q
);

    logic q_pos, q_neg;

    // Rising edge flip-flop
    always_ff @(posedge clk) begin
        q_pos <= d;
    end

    // Falling edge flip-flop
    always_ff @(negedge clk) begin
        q_neg <= d;
    end

    // Multiplexer to select between q_pos and q_neg
    always_comb begin
        if (clk) begin
            q = q_neg;
        end else begin
            q = q_pos;
        end
    end

endmodule