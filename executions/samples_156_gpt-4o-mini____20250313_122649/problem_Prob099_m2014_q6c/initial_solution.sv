module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    logic [5:0] next_state;

    // Next-state logic for Y2 and Y4
    assign next_state[0] = (y[0] & ~w) | (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & w) | (y[5] & w);
    assign next_state[1] = (y[0] & w) | (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);
    assign next_state[2] = (y[1] & w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);
    assign next_state[3] = (y[2] & w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);
    assign next_state[4] = (y[3] & w) | (y[4] & ~w) | (y[5] & ~w);
    assign next_state[5] = (y[4] & w) | (y[5] & ~w);

    // Output logic for Y1 and Y3
    assign Y1 = y[1];
    assign Y3 = y[3];

    // Synchronous reset
    always @(*) begin
        if (y == 6'b000001) begin
            next_state <= 6'b000001; // Reset to state A
        end else begin
            next_state <= next_state; // Update to next state
        end
    end

endmodule