module TopModule(
    input logic clk,              // Clock input
    input logic reset,            // Active-high synchronous reset
    input logic [2:0] s,          // 3-bit unsigned sensor input
    output logic fr2,             // Output for flow rate control
    output logic fr1,             // Output for flow rate control
    output logic fr0,             // Output for flow rate control
    output logic dfr              // Output for supplemental flow rate control
);

    typedef enum logic [1:0] {
        STATE_LOW = 2'b00,
        STATE_BETWEEN_MID_LOW = 2'b01,
        STATE_BETWEEN_HIGH_MID = 2'b10,
        STATE_HIGH = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_LOW;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default outputs
        fr0 = 1'b0;
        fr1 = 1'b0;
        fr2 = 1'b0;
        dfr = 1'b0;
        
        case (current_state)
            STATE_LOW: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (s == 3'b001) begin
                    next_state = STATE_BETWEEN_MID_LOW;
                end else begin
                    next_state = STATE_LOW;
                end
            end

            STATE_BETWEEN_MID_LOW: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                if (s == 3'b011) begin
                    next_state = STATE_BETWEEN_HIGH_MID;
                    dfr = 1'b1;
                end else if (s == 3'b000) begin
                    next_state = STATE_LOW;
                end else begin
                    next_state = STATE_BETWEEN_MID_LOW;
                end
            end

            STATE_BETWEEN_HIGH_MID: begin
                fr0 = 1'b1;
                if (s == 3'b111) begin
                    next_state = STATE_HIGH;
                    dfr = 1'b1;
                end else if (s == 3'b001) begin
                    next_state = STATE_BETWEEN_MID_LOW;
                end else begin
                    next_state = STATE_BETWEEN_HIGH_MID;
                end
            end

            STATE_HIGH: begin
                if (s == 3'b011) begin
                    next_state = STATE_BETWEEN_HIGH_MID;
                end else begin
                    next_state = STATE_HIGH;
                end
            end

            default: begin
                next_state = STATE_LOW;
            end
        endcase
    end

endmodule