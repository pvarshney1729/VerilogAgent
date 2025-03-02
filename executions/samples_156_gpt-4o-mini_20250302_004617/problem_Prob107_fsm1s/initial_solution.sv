module TopModule (
    input logic clk,
    input logic reset,
    output logic state_out
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
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
            A: next_state = B; // Transition from A to B
            B: next_state = A; // Transition from B to A
            default: next_state = A; // Default case
        endcase
    end

    // Output logic
    assign state_out = (current_state == A) ? 1'b1 : 1'b0;

endmodule