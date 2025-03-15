module state_machine (
    input logic clk,
    input logic reset,
    input logic w,
    output logic Y1,
    output logic Y2,
    output logic Y3,
    output logic Y4
);

    // State encoding using 6-bit one-hot encoding
    typedef enum logic [5:0] {
        A = 6'b000001,
        B = 6'b000010,
        C = 6'b000100,
        D = 6'b001000,
        E = 6'b010000,
        F = 6'b100000
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A; // Initialize to state A on reset
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : A;
            C: next_state = (w) ? D : A;
            D: next_state = (w) ? E : A;
            E: next_state = (w) ? F : A;
            F: next_state = (w) ? A : A;
            default: next_state = A; // Default case
        endcase
    end

    // Output logic based on current state
    assign Y1 = (current_state == A);
    assign Y2 = (current_state == B);
    assign Y3 = (current_state == C);
    assign Y4 = (current_state == D);

endmodule