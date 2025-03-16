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

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        out = 1'b0; // Default output
        next_state = current_state; // Default next_state to current_state
        case (current_state)
            A: begin
                next_state = (in) ? B : A;
            end
            B: begin
                next_state = (in) ? B : C;
            end
            C: begin
                next_state = (in) ? D : A;
            end
            D: begin
                next_state = (in) ? B : C;
                out = 1'b1; // Output for state D
            end
            default: begin
                next_state = A;
            end
        endcase
    end

endmodule
[DONE]