module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                next_state = (in) ? STATE_B : STATE_A;
                out = 1'b0;
            end
            STATE_B: begin
                next_state = (in) ? STATE_B : STATE_C;
                out = 1'b0;
            end
            STATE_C: begin
                next_state = (in) ? STATE_D : STATE_A;
                out = 1'b0;
            end
            STATE_D: begin
                next_state = (in) ? STATE_B : STATE_C;
                out = 1'b1;
            end
            default: begin
                next_state = STATE_A;
                out = 1'b0;
            end
        endcase
    end

endmodule