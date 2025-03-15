module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);
    typedef enum logic [1:0] {B = 2'b00, A = 2'b01} state_t;
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
                next_state = in ? B : A;
                out = 1'b1;
            end
            A: begin
                next_state = in ? A : B;
                out = 1'b0;
            end
            default: begin
                next_state = B;
                out = 1'b1;
            end
        endcase
    end
endmodule