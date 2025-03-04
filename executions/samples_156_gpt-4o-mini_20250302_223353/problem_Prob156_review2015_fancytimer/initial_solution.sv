module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        DETECT,
        COUNT,
        DONE_STATE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [9:0] cycle_count; // To count up to 1000 cycles
    logic delay_latched;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            cycle_count <= 10'b0000000000;
            delay_latched <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == COUNT) begin
                if (cycle_count == 10'd999) begin
                    cycle_count <= 10'b0000000000;
                    if (count > 4'b0000) begin
                        count <= count - 1'b1;
                    end
                end else begin
                    cycle_count <= cycle_count + 1'b1;
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            delay_latched <= 1'b0;
        end else if (current_state == DETECT && delay_latched) begin
            delay <= {delay[2:0], data};
            if (delay == 4'b1101) begin
                delay_latched <= 1'b1;
            end
        end else if (current_state == COUNT) begin
            if (count == 4'b0000) begin
                done <= 1'b1;
            end
        end else if (ack && done) begin
            done <= 1'b0;
            delay_latched <= 1'b0;
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = DETECT;
                end else begin
                    next_state = IDLE;
                end
                counting = 1'b0;
            end
            DETECT: begin
                if (delay_latched) begin
                    next_state = COUNT;
                    count = delay + 1'b1;
                    counting = 1'b1;
                end else begin
                    next_state = DETECT;
                end
            end
            COUNT: begin
                if (count == 4'b0000) begin
                    next_state = DONE_STATE;
                end else begin
                    next_state = COUNT;
                end
                counting = 1'b1;
            end
            DONE_STATE: begin
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = DONE_STATE;
                end
                counting = 1'b0;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule