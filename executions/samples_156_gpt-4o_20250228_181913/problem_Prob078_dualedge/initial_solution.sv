module TopModule (
    input logic clk,
    input logic d,
    input logic reset,
    output logic q
);

    logic q_pos, q_neg;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            q_pos <= 1'b0;
        else
            q_pos <= d;
    end

    always_ff @(negedge clk or posedge reset) begin
        if (reset)
            q_neg <= 1'b0;
        else
            q_neg <= d;
    end

    always_comb begin
        q = clk ? q_pos : q_neg;
    end

endmodule