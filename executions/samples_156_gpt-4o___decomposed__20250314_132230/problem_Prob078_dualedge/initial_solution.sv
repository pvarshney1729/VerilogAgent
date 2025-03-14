module TopModule(
    input  logic clk,
    input  logic d,
    output logic q
);

    logic q_pos, q_neg;

    always @(posedge clk) begin
        q_pos <= d;
    end

    always @(negedge clk) begin
        q_neg <= d;
    end

    always @(*) begin
        q = clk ? q_pos : q_neg;
    end

endmodule