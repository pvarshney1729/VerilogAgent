module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Output logic based on the current state
    assign out = (current_state == D) ? 1'b1 : 1'b0;

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = (in == 1'b0) ? A : B;
            B: next_state = (in == 1'b0) ? C : B;
            C: next_state = (in == 1'b0) ? A : D;
            D: next_state = (in == 1'b0) ? C : B;
            default: next_state = A; // Default case for safety
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk) begin
        if (areset) begin
            current_state <= A; // Reset state to A
        end else begin
            current_state <= next_state; // Update state
        end
    end

    // Initialize current state to A on reset
    initial begin
        current_state = A;
    end

endmodule