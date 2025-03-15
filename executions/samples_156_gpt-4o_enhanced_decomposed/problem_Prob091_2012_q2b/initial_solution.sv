module TopModule(
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    always @(*) begin
        // Logic for Y1: Transition to state B
        Y1 = y[0] & w;

        // Logic for Y3: Transition to state D
        Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w) | (y[5] & ~w);
    end

endmodule