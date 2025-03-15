[BEGIN]
module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    logic state, next_state;

    // State encoding
    localparam S0 = 1'b0;
    localparam S1 = 1'b1;

    // State register
    always_ff @(posedge clock) begin
        state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            S0: if (a) next_state = S1;
                else next_state = S0;
            S1: if (!a) next_state = S0;
                else next_state = S1;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_comb begin
        p = (state == S1) && a;
        q = (state == S0) && !a || (state == S1);
    end

endmodule
[DONE]