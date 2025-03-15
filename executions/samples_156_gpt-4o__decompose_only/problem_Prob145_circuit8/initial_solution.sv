module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clock) begin
        state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            S0: if (a) next_state = S1; else next_state = S0;
            S1: if (a) next_state = S2; else next_state = S0;
            S2: if (a) next_state = S3; else next_state = S0;
            S3: if (a) next_state = S1; else next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            S0: begin p = 0; q = 0; end
            S1: begin p = 1; q = 0; end
            S2: begin p = 1; q = 1; end
            S3: begin p = 0; q = 1; end
            default: begin p = 0; q = 0; end
        endcase
    end

endmodule