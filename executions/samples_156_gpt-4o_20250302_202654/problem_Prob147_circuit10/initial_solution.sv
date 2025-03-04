module TopModule (
    input logic clk,  // Clock signal, positive edge-triggered
    input logic a,    // Single-bit input signal 'a'
    input logic b,    // Single-bit input signal 'b'
    output logic q,   // Single-bit output signal 'q'
    output logic state // Single-bit output signal representing the flip-flop state
);

    // Initial state
    initial begin
        state = 1'b0;
        q = 1'b0;
    end

    always @(posedge clk) begin
        if (b == 1'b1) begin
            state <= 1'b1;
        end else if (a == 1'b1) begin
            state <= ~state;
        end
        q <= state;
    end

endmodule