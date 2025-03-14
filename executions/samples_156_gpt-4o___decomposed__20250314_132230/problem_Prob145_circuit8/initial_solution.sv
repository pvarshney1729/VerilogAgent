module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    typedef enum logic [1:0] {
        S0 = 2'b00,  // Initial state
        S1 = 2'b01,  // State where p is set
        S2 = 2'b10,  // State where q is set
        S3 = 2'b11   // State where both p and q might be set
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clock) begin
        current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S0: begin
                if (a) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (~a) next_state = S2;
                else next_state = S1;
            end
            S2: begin
                if (a) next_state = S1;
                else next_state = S3;
            end
            S3: begin
                if (a) next_state = S1;
                else next_state = S0;
            end
            default: next_state = S0; // Default case for safety
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            S0: begin
                p = 0;
                q = 0;
            end
            S1: begin
                p = 1;
                q = 0;
            end
            S2: begin
                p = 1;
                q = 1;
            end
            S3: begin
                p = 0;
                q = 1;
            end
            default: begin
                p = 'bx;
                q = 'bx;
            end
        endcase
    end

endmodule