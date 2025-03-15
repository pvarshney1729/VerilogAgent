module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);
    typedef enum logic [1:0] {A, B} state_t;
    state_t current_state, next_state;
    logic [2:0] w_history;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            w_history <= 3'b000;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == B) begin
                w_history <= {w_history[1:0], w}; // Shift in new w value
                if (w_history[2] + w_history[1] + w_history[0] == 2'b10) begin
                    z <= 1'b1;
                end else begin
                    z <= 1'b0;
                end
            end
        end
    end

    always_comb begin
        case (current_state)
            A: begin
                if (s) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                next_state = B; // Stay in B to continue checking w
            end
            default: next_state = A;
        endcase
    end
endmodule