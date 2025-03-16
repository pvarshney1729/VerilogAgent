module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    logic next_state;

    // Combinational logic to determine the next state and output q
    always @(*) begin
        if (a & b)
            next_state = ~state;
        else
            next_state = state;

        q = (b & ~state) | (~a & state);
    end

    // Sequential logic to update the state on the positive edge of the clock
    always_ff @(posedge clk) begin
        state <= next_state;
    end

endmodule