module fsm_one_hot (
    input logic clk,
    input logic reset,
    input logic w,
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

    state_t state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : A;
            C: next_state = w ? D : A;
            D: next_state = w ? E : A;
            E: next_state = w ? F : A;
            F: next_state = w ? A : A;
            default: next_state = A;
        endcase
    end

    // Output logic
    assign Y1 = (state == C) || (state == D);
    assign Y3 = (state == E) || (state == F);

endmodule