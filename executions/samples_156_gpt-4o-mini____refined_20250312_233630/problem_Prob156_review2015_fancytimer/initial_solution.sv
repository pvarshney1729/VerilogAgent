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
        WAIT_PATTERN,
        SHIFT_DELAY,
        COUNTING,
        DONE_STATE
    } state_t;

    state_t state, next_state;
    logic [3:0] delay;
    logic [9:0] counter; 
    logic [3:0] remaining_time;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counter <= 10'b0;
            delay <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == COUNTING) begin
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

    always @(*) begin
        next_state = state;
        count = 4'b0; 
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = WAIT_PATTERN;
                end
            end
            
            WAIT_PATTERN: begin
                if (data == 1'b1) begin
                    next_state = SHIFT_DELAY;
                end
            end
            
            SHIFT_DELAY: begin
                delay = {delay[2:0], data}; 
                if (delay[3] == 1'b1 && data == 1'b0) begin
                    remaining_time = delay; 
                    next_state = COUNTING;
                    counting = 1'b1;
                end
            end
            
            COUNTING: begin
                if (remaining_time == 4'b0 && counter == 10'd999) begin
                    next_state = DONE_STATE;
                    done = 1'b1;
                end
            end
            
            DONE_STATE: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
        
        if (state == COUNTING) begin
            count = remaining_time; 
        end
    end

endmodule
```
[DONE]