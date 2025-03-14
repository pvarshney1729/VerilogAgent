[BEGIN]
module TopModule (
    input logic clk,        // Clock input, single bit
    input logic areset,     // Asynchronous reset input, single bit
    input logic in,         // Input signal, single bit
    output logic out        // Output signal, single bit (registered)
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= A;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            // Output logic based on current state
            case (current_state)
                A: out <= 1'b0;
                B: out <= 1'b0;
                C: out <= 1'b0;
                D: out <= 1'b1;
                default: out <= out; // Hold previous value for unexpected states
            endcase
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            A: next_state = (in == 1'b0) ? A : B;
            B: next_state = (in == 1'b0) ? C : B;
            C: next_state = (in == 1'b0) ? A : D;
            D: next_state = (in == 1'b0) ? C : B;
            default: next_state = A; // Default case to handle unexpected states
        endcase
    end
endmodule
[DONE]