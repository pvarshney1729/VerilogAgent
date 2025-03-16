module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);
    logic ff_state;

    // Sequential logic (flip-flop)
    always @(posedge clk) begin
        if (a && !b) begin
            ff_state <= 1'b1;
        end else if (!a && b) begin
            ff_state <= 1'b0;
        end
    end

    // Combinational logic for output q
    assign q = ff_state;

    // Output state reflects the flip-flop state
    assign state = ff_state;

endmodule