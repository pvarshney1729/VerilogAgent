module dual_edge_ff (
    input logic clk,
    input logic reset,
    input logic d,
    output logic q
);

    logic q_next;

    // Combinational logic to determine next state
    always @(*) begin
        if (reset) begin
            q_next = 1'b0;
        end else begin
            q_next = d;
        end
    end

    // Rising edge triggered
    always @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            q <= q_next;
        end
    end

    // Falling edge triggered
    always @(negedge clk) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            q <= q_next;
        end
    end

endmodule