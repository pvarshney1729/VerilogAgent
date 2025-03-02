module TopModule (
    input logic clk,
    input logic reset,
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

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        case (current_state)
            A: begin
                if (in) next_state <= B;
                else next_state <= A;
                out <= 1'b0;
            end
            B: begin
                if (in) next_state <= B;
                else next_state <= C;
                out <= 1'b0;
            end
            C: begin
                if (in) next_state <= D;
                else next_state <= A;
                out <= 1'b0;
            end
            D: begin
                if (in) next_state <= B;
                else next_state <= C;
                out <= 1'b1;
            end
            default: begin
                next_state <= A;
                out <= 1'b0;
            end
        endcase
    end

endmodule