module TopModule (
    input logic clk,
    input logic reset,
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

    state_t current_state, next_state;

    // Sequential logic for state transition with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A; // Reset to state A
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (current_state)
            A: begin
                next_state = (in == 1'b0) ? A : B;
                out = 1'b0;
            end
            B: begin
                next_state = (in == 1'b0) ? C : B;
                out = 1'b0;
            end
            C: begin
                next_state = (in == 1'b0) ? A : D;
                out = 1'b0;
            end
            D: begin
                next_state = (in == 1'b0) ? C : B;
                out = 1'b1;
            end
            default: begin
                next_state = A; // Default case to avoid latches
                out = 1'b0;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly