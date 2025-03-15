module pattern_detector (
    input logic clk,
    input logic reset,
    input logic ack,
    input logic data_in,
    output logic detected,
    output logic [3:0] countdown
);

    typedef enum logic [1:0] {
        IDLE,
        DETECT,
        COUNTDOWN
    } state_t;

    state_t current_state, next_state;
    logic [3:0] count;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == COUNTDOWN) begin
                count <= count - 4'b0001;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        detected = 1'b0;

        case (current_state)
            IDLE: begin
                if (data_in == 1'b1) begin
                    next_state = DETECT;
                end
            end

            DETECT: begin
                if (data_in == 1'b1) begin
                    // Assuming we have a way to check the last three bits
                    // For simplicity, we assume a signal 'pattern_matched' indicates '1101'
                    if (pattern_matched) begin
                        detected = 1'b1;
                        count = 4'b1000; // Start countdown from 8
                        next_state = COUNTDOWN;
                    end
                end else begin
                    next_state = IDLE;
                end
            end

            COUNTDOWN: begin
                if (count == 4'b0000) begin
                    next_state = IDLE;
                end else if (ack) begin
                    next_state = IDLE; // Acknowledge resets the state
                end
            end
        endcase
    end

    assign countdown = count;

endmodule