module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic {B, A} state_t;
    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            B: begin
                out = 1'b1;
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            A: begin
                out = 1'b0;
                if (in) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            default: begin
                out = 1'b0;
                next_state = B;
            end
        endcase
    end

endmodule