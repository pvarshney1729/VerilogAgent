```verilog
[BEGIN]
module TopModule (
    input  logic clk,            // Clock input, positive edge triggered
    input  logic reset,          // Active-high synchronous reset
    input  logic data,           // Serial data input
    input  logic ack,            // Acknowledgment from user
    output logic [3:0] count,    // 4-bit output for remaining time
    output logic counting,        // Indicates if the module is currently counting
    output logic done             // Indicates completion of timing sequence
);

    // State Encoding
    typedef enum logic [2:0] {
        WAIT_PATTERN = 3'd0,
        SHIFT_DELAY  = 3'd1,
        COUNTING     = 3'd2,
        DONE_STATE   = 3'd3
    } state_t;

    state_t state, next_state;
    logic [3:0] delay;
    logic [12:0] cycle_counter; // To count up to 1000 cycles
    logic [3:0] delay_counter;

    // State Transition Logic
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_PATTERN;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0000;
            delay_counter <= 4'b0000;
            cycle_counter <= 13'd0;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic and Output Logic
    always @(*) begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            WAIT_PATTERN: begin
                if (data == 1'b1) begin
                    next_state = SHIFT_DELAY;
                end
            end
            
            SHIFT_DELAY: begin
                if (delay_counter == 4'd3) begin
                    next_state = COUNTING;
                end
            end
            
            COUNTING: begin
                counting = 1'b1;
                if (cycle_counter == 13'd999) begin
                    cycle_counter = 13'd0;
                    if (count == 4'b0000) begin
                        next_state = DONE_STATE;
                    end else begin
                        count = count - 1;
                    end
                end else begin
                    cycle_counter = cycle_counter + 1;
                end
            end
            
            DONE_STATE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = WAIT_PATTERN;
                end
            end
            
            default: begin
                next_state = WAIT_PATTERN;
            end
        endcase
    end

    // Pattern and Delay Shift Logic
    always @(posedge clk) begin
        if (state == WAIT_PATTERN) begin
            delay_counter <= 4'b0000;
        end else if (state == SHIFT_DELAY) begin
            delay <= {delay[2:0], data};
            delay_counter <= delay_counter + 1;
        end
    end

    // Initialize count when entering COUNTING state
    always @(posedge clk) begin
        if (state == SHIFT_DELAY && next_state == COUNTING) begin
            count <= delay;
        end
    end

    // Default behavior for count when not counting
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (!counting) begin
            count <= 4'b0000;
        end
    end

endmodule
[DONE]
```