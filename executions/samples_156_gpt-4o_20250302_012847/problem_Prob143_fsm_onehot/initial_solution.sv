module state_machine (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out1,
    output logic out2
);

    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_INVALID = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_0: next_state = in ? STATE_1 : STATE_0;
            STATE_1: next_state = in ? STATE_2 : STATE_0;
            STATE_2: next_state = in ? STATE_2 : STATE_1;
            default: next_state = STATE_INVALID;
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_0;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        out1 = 1'b0;
        out2 = 1'b0;
        case (current_state)
            STATE_0: begin
                out1 = 1'b0;
                out2 = 1'b0;
            end
            STATE_1: begin
                out1 = 1'b1;
                out2 = 1'b0;
            end
            STATE_2: begin
                out1 = 1'b0;
                out2 = 1'b1;
            end
            default: begin
                out1 = 1'b0;
                out2 = 1'b0;
            end
        endcase
    end

endmodule