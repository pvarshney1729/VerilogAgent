module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);
    typedef enum logic [1:0] {A, B, C, D} state_t;
    state_t current_state, next_state;

    always @(posedge clk) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            A: next_state = (in == 1'b0) ? A : B;
            B: next_state = (in == 1'b0) ? C : B;
            C: next_state = (in == 1'b0) ? A : D;
            D: next_state = (in == 1'b0) ? C : B;
            default: next_state = A;
        endcase
    end

    assign out = (current_state == D) ? 1'b1 : 1'b0;

endmodule