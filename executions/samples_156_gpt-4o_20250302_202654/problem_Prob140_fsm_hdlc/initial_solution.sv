module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [3:0] {
        IDLE = 4'b0000,
        ONE_1 = 4'b0001,
        ONE_2 = 4'b0010,
        ONE_3 = 4'b0011,
        ONE_4 = 4'b0100,
        ONE_5 = 4'b0101,
        FLAG_DETECT = 4'b0110,
        DISC_DETECT = 4'b0111,
        ERROR = 4'b1000
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (in) next_state = ONE_1;
            end
            ONE_1: begin
                if (in) next_state = ONE_2;
                else next_state = IDLE;
            end
            ONE_2: begin
                if (in) next_state = ONE_3;
                else next_state = IDLE;
            end
            ONE_3: begin
                if (in) next_state = ONE_4;
                else next_state = IDLE;
            end
            ONE_4: begin
                if (in) next_state = ONE_5;
                else next_state = IDLE;
            end
            ONE_5: begin
                if (in) next_state = ERROR;
                else next_state = FLAG_DETECT;
            end
            FLAG_DETECT: begin
                flag = 1'b1;
                if (in) next_state = ONE_1;
                else next_state = IDLE;
            end
            DISC_DETECT: begin
                disc = 1'b1;
                if (in) next_state = ONE_1;
                else next_state = IDLE;
            end
            ERROR: begin
                err = 1'b1;
                if (!in) next_state = IDLE;
            end
        endcase
    end

endmodule