module TopModule (
    input logic clk,
    input logic reset,
    input logic w,
    output logic z
);

    typedef enum logic [2:0] {A, B, C, D, E, F} state_t;
    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            A: begin
                z = 1'b0;
                if (w) next_state = A;
                else next_state = B;
            end
            B: begin
                z = 1'b0;
                if (w) next_state = D;
                else next_state = C;
            end
            C: begin
                z = 1'b0;
                if (w) next_state = D;
                else next_state = E;
            end
            D: begin
                z = 1'b0;
                if (w) next_state = A;
                else next_state = F;
            end
            E: begin
                z = 1'b1;
                if (w) next_state = D;
                else next_state = E;
            end
            F: begin
                z = 1'b1;
                if (w) next_state = D;
                else next_state = C;
            end
            default: begin
                z = 1'b0;
                next_state = A;
            end
        endcase
    end

endmodule