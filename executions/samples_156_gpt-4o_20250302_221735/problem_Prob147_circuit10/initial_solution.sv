module TopModule (
    input  logic clk,     // Clock signal
    input  logic a,       // Input signal 'a'
    input  logic b,       // Input signal 'b'
    output logic q,       // Output signal 'q'
    output logic state    // Observable state of the flip-flop
);

    logic state_next;     // Next state logic

    // Combinational logic for next state and output q
    always @(*) begin
        state_next = (a & ~b & state) | (~a & b & ~state);
        q = (state & ~a & b) | (~state & a & b);
    end

    // Sequential logic for state update
    always @(posedge clk) begin
        state <= state_next;
    end

endmodule