module TopModule (
    input logic clk,           // Clock signal for sequential logic
    input logic reset,         // Active-high synchronous reset
    input logic [2:0] s,       // 3-bit bus for sensor inputs: s[2] = highest, s[0] = lowest
    output logic fr2,          // Flow rate control output 2
    output logic fr1,          // Flow rate control output 1
    output logic fr0,          // Flow rate control output 0
    output logic dfr           // Supplemental flow valve control
);

    typedef enum logic [1:0] {
        STATE_BELOW_S0 = 2'b00,
        STATE_BETWEEN_S1_S0 = 2'b01,
        STATE_BETWEEN_S2_S1 = 2'b10,
        STATE_ABOVE_S2 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_BELOW_S0;
            fr0 <= 1'b1;
            fr1 <= 1'b1;
            fr2 <= 1'b1;
            dfr <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_ABOVE_S2: begin
                if (s[2] == 1'b0) 
                    next_state = STATE_BETWEEN_S2_S1;
                else 
                    next_state = STATE_ABOVE_S2;
            end
            STATE_BETWEEN_S2_S1: begin
                if (s[1] == 1'b0) 
                    next_state = STATE_BETWEEN_S1_S0;
                else 
                    next_state = STATE_BETWEEN_S2_S1;
            end
            STATE_BETWEEN_S1_S0: begin
                if (s[0] == 1'b0) 
                    next_state = STATE_BELOW_S0;
                else 
                    next_state = STATE_BETWEEN_S1_S0;
            end
            STATE_BELOW_S0: begin
                if (s[0] == 1'b1) 
                    next_state = STATE_BETWEEN_S1_S0;
                else 
                    next_state = STATE_BELOW_S0;
            end
            default: next_state = STATE_BELOW_S0;
        endcase
    end

    // Output logic based on current state
    always @(*) begin
        fr0 = 1'b0;
        fr1 = 1'b0;
        fr2 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            STATE_ABOVE_S2: begin
                // All outputs deasserted
            end
            STATE_BETWEEN_S2_S1: begin
                fr0 = 1'b1;
            end
            STATE_BETWEEN_S1_S0: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
            end
            STATE_BELOW_S0: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                fr2 = 1'b1;
            end
        endcase

        // Supplemental flow valve control
        if (current_state == STATE_BETWEEN_S1_S0 && next_state == STATE_BETWEEN_S2_S1) begin
            dfr = 1'b1;
        end
    end

endmodule