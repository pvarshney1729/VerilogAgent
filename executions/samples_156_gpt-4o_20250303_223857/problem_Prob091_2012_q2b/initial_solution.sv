module TopModule (
    input logic clk,            // Clock signal for synchronous operations
    input logic reset,          // Active-high reset signal
    input logic [5:0] y,        // 6-bit one-hot encoded state input
    input logic w,              // 1-bit input signal
    output logic Y1,            // 1-bit output signal for state flip-flop y[1]
    output logic Y3             // 1-bit output signal for state flip-flop y[3]
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

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A; // Default to safe state
        endcase
    end

    // Output logic
    always_comb begin
        Y1 = (current_state == B);
        Y3 = (current_state == D);
    end

endmodule