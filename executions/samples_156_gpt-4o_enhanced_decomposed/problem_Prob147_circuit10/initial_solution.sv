module TopModule(
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    logic next_state;

    // Combinational logic for q
    always @(*) begin
        q = (state & a & ~b) | (~state & b);
    end

    // Sequential logic for state
    always @(posedge clk) begin
        if (a & b) begin
            next_state = ~state;
        end else begin
            next_state = state;
        end
        state <= next_state;
    end

endmodule