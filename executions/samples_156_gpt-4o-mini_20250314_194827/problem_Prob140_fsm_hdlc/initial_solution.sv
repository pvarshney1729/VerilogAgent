module fsm (
    input logic clk,
    input logic reset,
    input logic data_in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        S_IDLE = 3'b000,
        S_PATTERN1 = 3'b001,
        S_PATTERN2 = 3'b010,
        S_ERROR = 3'b011,
        S_DONE = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S_IDLE: begin
                if (data_in) 
                    next_state = S_PATTERN1;
                else 
                    next_state = S_IDLE;
            end
            S_PATTERN1: begin
                if (data_in) 
                    next_state = S_PATTERN2;
                else 
                    next_state = S_IDLE;
            end
            S_PATTERN2: begin
                next_state = S_DONE; // Assuming a valid pattern is detected
            end
            S_DONE: begin
                next_state = S_IDLE; // Return to idle after processing
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) 
            current_state <= S_IDLE;
        else 
            current_state <= next_state;
    end

    // Output logic based on current state
    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            S_DONE: begin
                disc = 1'b1; // Indicate successful detection
                flag = 1'b1; // Set flag for valid pattern
            end
            S_ERROR: begin
                err = 1'b1; // Indicate error state
            end
            default: begin
                // No outputs in other states
            end
        endcase
    end

endmodule