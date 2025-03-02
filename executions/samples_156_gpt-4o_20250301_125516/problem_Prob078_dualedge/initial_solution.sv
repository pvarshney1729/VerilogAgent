module TopModule (
    input logic clk,
    input logic d,
    input logic reset,
    output logic q
);

    logic q_rising, q_falling;

    // Rising edge flip-flop
    always_ff @(posedge clk) begin
        if (reset) begin
            q_rising <= 1'b0;
        end else begin
            q_rising <= d;
        end
    end

    // Falling edge flip-flop
    always_ff @(negedge clk) begin
        if (reset) begin
            q_falling <= 1'b0;
        end else begin
            q_falling <= d;
        end
    end

    // Combinational logic to determine the output q
    always_comb begin
        q = q_rising | q_falling;
    end

endmodule