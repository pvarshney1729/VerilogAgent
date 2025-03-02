module fsm_sequence_detector (
    input logic clk,
    input logic rst_n,
    input logic x,
    output logic f,
    output logic g
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (!rst_n) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x) next_state = B;
                else next_state = A;
            end
            B: begin
                if (!x) next_state = C;
                else next_state = B;
            end
            C: begin
                if (x) next_state = D;
                else next_state = A;
            end
            D: begin
                if (x) next_state = B; // Loop back to B for the next '1'
                else next_state = A;    // Reset to A on '0'
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    assign f = (state == D); // Output f is high when in state D
    assign g = (state == C); // Output g is high when in state C

endmodule