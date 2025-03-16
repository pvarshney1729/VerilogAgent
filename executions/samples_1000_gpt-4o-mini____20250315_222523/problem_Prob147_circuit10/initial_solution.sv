module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    logic ff_state;

    // Combinational logic to determine the next state of the flip-flop
    always @(*) begin
        if (ff_state == 1'b0) begin
            if (a && !b) begin
                q = 1'b0;
            end else if (a && b) begin
                q = 1'b1;
            end else begin
                q = ff_state;
            end
        end else begin
            q = ff_state;
        end
    end

    // Sequential logic for the flip-flop
    always @(posedge clk) begin
        ff_state <= q;
    end

    // Output the state of the flip-flop
    assign state = ff_state;

endmodule