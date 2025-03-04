module TopModule (
    input logic [5:0] y,    // 6-bit one-hot encoded current state
    input logic w,          // 1-bit input signal, unsigned
    output logic Y1,        // 1-bit output signal, unsigned
    output logic Y3,        // 1-bit output signal, unsigned
    output logic Y2,        // 1-bit next-state signal corresponding to state B (y[1])
    output logic Y4         // 1-bit next-state signal corresponding to state D (y[3])
);

    // Combinational logic for next-state signals
    always @(*) begin
        Y2 = (y[0] & ~w) | (y[5] & ~w);
        Y4 = (y[1] & w) | (y[2] & w) | (y[4] & w) | (y[5] & w);
    end

    // Initialize outputs to 0
    initial begin
        Y1 = 1'b0;
        Y3 = 1'b0;
    end

endmodule