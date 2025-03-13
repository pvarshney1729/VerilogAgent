[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State register logic with synchronous reset
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= A; // Synchronous reset to state A
        end else begin
            current_state <= next_state; // Update state on clock edge
        end
    end

    // Combinational logic for next state
    always_comb begin
        case (current_state)
            A: next_state = (in == 1'b0) ? A : B;
            B: next_state = (in == 1'b0) ? C : B;
            C: next_state = (in == 1'b0) ? A : D;
            D: next_state = (in == 1'b0) ? C : B;
            default: next_state = A; // Default to state A for safety
        endcase
    end

    // Define the output logic for the FSM
    always_comb begin
        case (current_state)
            A: out = 1'b0;
            B: out = 1'b0;
            C: out = 1'b0;
            D: out = 1'b1;
            default: out = 1'b0;  // Default case for safety
        endcase
    end

endmodule
[DONE]