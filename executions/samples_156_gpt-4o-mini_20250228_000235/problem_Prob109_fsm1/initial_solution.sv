module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic in,
    output logic out
);

    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        case (state)
            A: begin
                if (in == 1'b0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (in == 1'b0) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            default: next_state = B; // Default case to avoid latches
        endcase
    end

    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule