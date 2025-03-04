module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);

    typedef enum logic [2:0] {
        STATE_0 = 3'b000, // Idle state
        STATE_1 = 3'b001, // Detected first '1'
        STATE_2 = 3'b010, // Detected '11'
        STATE_3 = 3'b011, // Detected '110'
        STATE_4 = 3'b100  // Detected '1101'
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_0;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (next_state == STATE_4) begin
                start_shifting <= 1'b1;
            end
        end
    end

    always_comb begin
        case (current_state)
            STATE_0: begin
                if (data) begin
                    next_state = STATE_1;
                end else begin
                    next_state = STATE_0;
                end
            end
            STATE_1: begin
                if (data) begin
                    next_state = STATE_2;
                end else begin
                    next_state = STATE_0;
                end
            end
            STATE_2: begin
                if (data) begin
                    next_state = STATE_3;
                end else begin
                    next_state = STATE_0;
                end
            end
            STATE_3: begin
                if (data) begin
                    next_state = STATE_4;
                end else begin
                    next_state = STATE_0;
                end
            end
            STATE_4: begin
                next_state = STATE_0; // Reset to idle after detecting "1101"
            end
            default: next_state = STATE_0; // Default case to avoid latches
        endcase
    end

endmodule