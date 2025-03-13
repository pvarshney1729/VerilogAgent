[BEGIN]
module TopModule (
    input logic clk,        // Clock input (1-bit)
    input logic reset,      // Synchronous active high reset (1-bit)
    input logic in,         // Input signal (1-bit)
    output logic out        // Output signal (1-bit)
);

    // State encoding
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
            out <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic based on current state
    always @(*) begin
        case (current_state)
            A: out = 1'b0;
            B: out = 1'b0;
            C: out = 1'b0;
            D: out = 1'b1;
            default: out = 1'b0; // Default case for safety
        endcase
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A; // Default case to avoid latches
        endcase
    end

endmodule
[DONE]