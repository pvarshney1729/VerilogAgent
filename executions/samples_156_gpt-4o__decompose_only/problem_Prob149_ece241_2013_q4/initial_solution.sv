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
        STATE_ABOVE_S2 = 2'b00,      // Water level above s[2]
        STATE_BETWEEN_S2_S1 = 2'b01, // Water level between s[2] and s[1]
        STATE_BETWEEN_S1_S0 = 2'b10, // Water level between s[1] and s[0]
        STATE_BELOW_S0 = 2'b11       // Water level below s[0]
    } state_t;

    state_t current_state, next_state;
    logic [2:0] prev_s;

    // State transition and output logic
    always_ff @(posedge clk or posedge reset) begin
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
                    dfr <= 1'b0;
                end
            endcase
        end
    end

    // Next state logic
    always_comb begin
        case (s)
            3'b111: next_state = STATE_ABOVE_S2;
            3'b011: next_state = STATE_BETWEEN_S2_S1;
            3'b001: next_state = STATE_BETWEEN_S1_S0;
            3'b000: next_state = STATE_BELOW_S0;
            default: next_state = STATE_BELOW_S0; // Default to lowest state
        endcase
    end

endmodule