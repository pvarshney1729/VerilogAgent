module TopModule (
    input logic clk,
    input logic reset,
    input logic w,
    output logic z
);

    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            A: begin
                if (w == 1'b0) next_state = B;
                else next_state = A;
            end
            B: begin
                if (w == 1'b0) next_state = C;
                else next_state = D;
            end
            C: begin
                if (w == 1'b0) next_state = E;
                else next_state = D;
            end
            D: begin
                if (w == 1'b0) next_state = F;
                else next_state = A;
            end
            E: begin
                if (w == 1'b0) next_state = E;
                else next_state = D;
            end
            F: begin
                if (w == 1'b0) next_state = C;
                else next_state = D;
            end
            default: next_state = A; // Default state
        endcase
    end

    assign z = (current_state == E) ? 1'b1 : 1'b0;

endmodule