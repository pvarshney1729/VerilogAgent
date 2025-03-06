```verilog
[BEGIN]
module TopModule (
    input  logic clk,    // Clock signal: positive-edge triggered
    input  logic reset,  // Synchronous active high reset
    input  logic in,     // FSM input signal
    output logic out     // FSM output signal
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

    // Output logic and next state determination based on current state
    always @(*) begin
        out = 1'b0; // Default output
        next_state = current_state; // Default next state

        case (current_state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: begin
                out = 1'b1;
                next_state = (in) ? B : C;
            end
            default: next_state = A; // Default to state A for undefined states
        endcase
    end

endmodule
[DONE]
```