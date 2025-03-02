module TopModule (
    input  logic clk,
    input  logic a,
    input  logic b,
    output logic q,
    output logic state
);

    logic ff_state;

    // Combinational logic to determine the next state of the flip-flop
    always @(*) begin
        if (a && !b) begin
            q = 1'b1;
        end else if (!a && b) begin
            q = 1'b0;
        end else begin
            q = ff_state; // Hold state
        end
    end

    // Sequential logic to update the flip-flop state
    always @(posedge clk) begin
        ff_state <= q;
    end

    assign state = ff_state;

endmodule