module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);
    logic ff_state;

    // Flip-flop to hold the state
    always @(posedge clk) begin
        if (a && !b) begin
            ff_state <= 1'b1;
        end else if (!a && b) begin
            ff_state <= 1'b0;
        end
    end

    // Combinational logic for output q
    assign q = ff_state;

    // Output state is the current state of the flip-flop
    assign state = ff_state;

endmodule