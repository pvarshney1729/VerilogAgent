module TopModule (
    input logic clk,   // 1-bit clock input
    input logic a,     // 1-bit input
    input logic b,     // 1-bit input
    output logic q,    // 1-bit output
    output logic state // 1-bit output representing the state of the flip-flop
);

    logic next_state, next_q;

    // Combinational logic to determine next state and output q
    always @(*) begin
        if (b) begin
            next_state = a;
            next_q = a;
        end else begin
            next_state = state;
            next_q = (a) ? ~q : q;
        end
    end

    // Sequential logic to update state and q on the rising edge of clk
    always_ff @(posedge clk) begin
        state <= next_state;
        q <= next_q;
    end

endmodule