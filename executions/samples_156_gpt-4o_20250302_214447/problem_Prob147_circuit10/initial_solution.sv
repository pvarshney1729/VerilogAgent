module TopModule (
    input  wire clk,   // Clock signal, positive edge-triggered
    input  wire a,     // 1-bit input signal
    input  wire b,     // 1-bit input signal
    output reg  q,     // 1-bit output signal, combinational logic
    output reg  state  // 1-bit output signal, flip-flop state
);

    // Combinational logic to determine q
    always @(*) begin
        if (a ^ b) begin
            q = ~state;
        end else begin
            q = state;
        end
    end

    // Sequential logic to update state on positive edge of clk
    always @(posedge clk) begin
        state <= q;
    end

endmodule