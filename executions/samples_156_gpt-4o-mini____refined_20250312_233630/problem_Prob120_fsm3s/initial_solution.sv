[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic out
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

    // Combinational logic for next state and output
    always @(*) begin
        out = 1'b0; // Default output value
        next_state = current_state; // Default next state

        case (current_state)
            A: begin
                next_state = (in == 1'b0) ? A : B;
            end
            B: begin
                next_state = (in == 1'b0) ? C : B;
            end
            C: begin
                next_state = (in == 1'b0) ? A : D;
            end
            D: begin
                next_state = (in == 1'b0) ? C : B;
                out = 1'b1; // Output for state D
            end
            default: begin
                next_state = A;
            end
        endcase
    end

endmodule
```
[DONE]