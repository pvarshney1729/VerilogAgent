module TopModule (
    input logic [5:0] y,  // 6-bit input vector representing the one-hot encoded state
    input logic w,        // 1-bit input used for state transitions
    input logic clk,      // Clock input for synchronous logic
    output logic Y1,      // 1-bit output
    output logic Y3       // 1-bit output
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

    // Synchronous state transition with reset
    always @(posedge clk) begin
        if (y == 6'b000000) begin
            current_state <= A; // Reset to State A
        end else begin
            current_state <= next_state;
        end
    end

    // Next-state logic
    always @(*) begin
        case (current_state)
            A: next_state = (w == 1'b0) ? B : A;
            B: next_state = (w == 1'b0) ? C : D;
            C: next_state = (w == 1'b0) ? E : D;
            D: next_state = (w == 1'b0) ? F : A;
            E: next_state = (w == 1'b0) ? E : D;
            F: next_state = (w == 1'b0) ? C : D;
            default: next_state = A; // Handle invalid states
        endcase
    end

    // Output logic
    always @(*) begin
        Y1 = (current_state == E || current_state == F) ? 1'b1 : 1'b0;
        Y3 = (current_state == D) ? 1'b1 : 1'b0;
    end

endmodule