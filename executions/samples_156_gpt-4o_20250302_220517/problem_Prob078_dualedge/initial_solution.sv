module TopModule (
    input logic clk,
    input logic reset_n,
    input logic d,
    output logic q
);

    logic q_pos, q_neg;

    // Rising edge triggered block
    always_ff @(posedge clk) begin
        if (!reset_n)
            q_pos <= 1'b0;
        else
            q_pos <= d;
    end

    // Falling edge triggered block
    always_ff @(negedge clk) begin
        if (!reset_n)
            q_neg <= 1'b0;
        else
            q_neg <= d;
    end

    // Combine results from both edges
    always_comb begin
        q = q_pos | q_neg;
    end

endmodule