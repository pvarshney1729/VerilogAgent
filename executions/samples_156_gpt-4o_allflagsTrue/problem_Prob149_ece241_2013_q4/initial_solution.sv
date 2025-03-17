module TopModule (
    input logic clk,
    input logic reset,
    input logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_ABOVE_S2 = 2'b11,
        STATE_BETWEEN_S2_S1 = 2'b10,
        STATE_BETWEEN_S1_S0 = 2'b01,
        STATE_BELOW_S0 = 2'b00
    } state_t;

    state_t current_state, next_state;
    logic [2:0] prev_s;

    // State transition logic
    always @(*) begin
        case (s)
            3'b111: next_state = STATE_ABOVE_S2;
            3'b011: next_state = STATE_BETWEEN_S2_S1;
            3'b001: next_state = STATE_BETWEEN_S1_S0;
            3'b000: next_state = STATE_BELOW_S0;
            default: next_state = STATE_BELOW_S0; // Default to low for safety
        endcase
    end

    // Sequential logic for state update and output generation
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_BELOW_S0;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b1;
            prev_s <= 3'b000;
        end else begin
            current_state <= next_state;
            prev_s <= s;
            case (next_state)
                STATE_ABOVE_S2: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b0;
                    dfr <= 1'b0;
                end
                STATE_BETWEEN_S2_S1: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b1;
                    dfr <= (prev_s < s) ? 1'b1 : 1'b0;
                end
                STATE_BETWEEN_S1_S0: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= (prev_s < s) ? 1'b1 : 1'b0;
                end
                STATE_BELOW_S0: begin
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= 1'b1;
                end
            endcase
        end
    end

endmodule