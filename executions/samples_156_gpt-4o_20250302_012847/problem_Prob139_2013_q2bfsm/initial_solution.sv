module state_machine (
    input logic clk,
    input logic reset,
    output logic f,
    output logic g
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = STATE_B;
            STATE_B: next_state = STATE_C;
            STATE_C: next_state = STATE_A;
            default: next_state = STATE_A;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        f = 1'b0;
        g = 1'b0;
        case (current_state)
            STATE_A: begin
                f = 1'b1;
                g = 1'b0;
            end
            STATE_B: begin
                f = 1'b0;
                g = 1'b1;
            end
            STATE_C: begin
                f = 1'b1;
                g = 1'b1;
            end
        endcase
    end

endmodule