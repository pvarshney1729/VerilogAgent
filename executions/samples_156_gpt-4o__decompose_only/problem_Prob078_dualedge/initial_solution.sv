module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

    logic q_pos, q_neg;

    // Positive edge triggered flip-flop
    always @(posedge clk) begin
        q_pos <= d;
    end

    // Negative edge triggered flip-flop
    always @(negedge clk) begin
        q_neg <= d;
    end

    // Multiplexer to select the output based on the clock edge
    always @(*) begin
        q = clk ? q_pos : q_neg;
    end

endmodule