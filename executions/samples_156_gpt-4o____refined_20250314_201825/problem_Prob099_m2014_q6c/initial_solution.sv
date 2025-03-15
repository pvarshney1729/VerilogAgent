module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    // Next-state logic for Y2 (y[1]) and Y4 (y[3])
    logic Y2, Y4;

    always @(*) begin
        // Y2 corresponds to state B (000010)
        Y2 = (y[0] & ~w) | (y[3] & ~w);

        // Y4 corresponds to state D (001000)
        Y4 = (y[1] & w) | (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w);
    end

    // Assign outputs
    assign Y1 = y[4]; // State E
    assign Y3 = y[3]; // State D

endmodule