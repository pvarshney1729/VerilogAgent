module fsm (
    input logic clk,
    input logic reset,
    input logic in,
    output logic [1:0] state
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? C : A;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : A;
            default: next_state = A;
        endcase
    end

    // Output the current state
    assign state = current_state;

endmodule