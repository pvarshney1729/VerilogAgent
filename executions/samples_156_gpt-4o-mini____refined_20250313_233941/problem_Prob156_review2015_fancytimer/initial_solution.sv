[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic data,
    output logic [3:0] count,
    output logic counting,
    output logic done,
    input  logic ack
);

    typedef enum logic [2:0] {
        IDLE,
        DETECT,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;
    logic [3:0] delay;
    logic [9:0] counter; // 1000 cycles max
    logic [3:0] remaining_time;

    // Sequential logic for state and counter management
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counter <= 10'b0;
            delay <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == COUNT) begin
                if (counter < 10'd999) begin
                    counter <= counter + 10'b1;
                end else begin
                    counter <= 10'b0;
                    if (remaining_time > 4'b0) begin
                        remaining_time <= remaining_time - 4'b1;
                    end
                end
            end
        end
    end

    // Sequential logic for count output
    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 4'b0;
        end else if (state == COUNT) begin
            count <= remaining_time;
        end else begin
            count <= 4'b0; // Don't care when not counting
        end
    end

    // Combinational logic for state transitions
    always_comb begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = DETECT;
                end
            end
            DETECT: begin
                if (data == 1'b1) begin
                    next_state = SHIFT;
                end
            end
            SHIFT: begin
                if (counter < 10'd15) begin // Shift in 4 bits
                    delay <= {delay[2:0], data};
                    counter <= counter + 10'b1;
                end else begin
                    remaining_time = delay;
                    counting = 1'b1;
                    next_state = COUNT;
                end
            end
            COUNT: begin
                if (remaining_time == 4'b0) begin
                    done = 1'b1;
                    next_state = DONE;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                    delay <= 4'b0;
                end
            end
        endcase
    end

endmodule
```
[DONE]