module state_machine (
    input logic clk,
    input logic reset,
    output logic Y1,
    output logic Y3
);

    // State encoding
    typedef enum logic [5:0] {
        A = 6'b000001,
        B = 6'b000010,
        C = 6'b000100,
        D = 6'b001000,
        E = 6'b010000,
        F = 6'b100000
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= 6'b000000; // Initialize to zero
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = B;
            B: next_state = C;
            C: next_state = D;
            D: next_state = E;
            E: next_state = F;
            F: next_state = A;
            default: next_state = A; // Default to state A
        endcase
    end

    // Output logic based on current state
    assign Y1 = (current_state == C) || (current_state == E);
    assign Y3 = (current_state == A) || (current_state == D);

endmodule