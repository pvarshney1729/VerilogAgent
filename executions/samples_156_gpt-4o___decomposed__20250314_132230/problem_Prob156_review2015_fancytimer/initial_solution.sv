module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    // Internal signals
    logic [3:0] delay;
    logic [3:0] pattern_shift_reg;
    logic [13:0] cycle_counter;
    logic [2:0] state, next_state;

    // State encoding
    localparam IDLE         = 3'b000;
    localparam DETECT_1     = 3'b001;
    localparam DETECT_11    = 3'b010;
    localparam DETECT_110   = 3'b011;
    localparam DETECT_1101  = 3'b100;
    localparam LOAD_DELAY   = 3'b101;
    localparam COUNTING     = 3'b110;
    localparam DONE         = 3'b111;

    // State Machine
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'b0000;
            pattern_shift_reg <= 4'b0000;
            cycle_counter <= 14'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default to hold state
        case (state)
            IDLE: begin
                pattern_shift_reg = {pattern_shift_reg[2:0], data};
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                delay = {delay[2:0], data};
                if (&delay) begin // All bits shifted in
                    next_state = COUNTING;
                    cycle_counter = 1000;
                    counting = 1'b1;
                    count = delay;
                end
            end
            COUNTING: begin
                if (cycle_counter == 0) begin
                    if (count > 0) begin
                        count = count - 1;
                        cycle_counter = 1000;
                    end else begin
                        next_state = DONE;
                        counting = 1'b0;
                        done = 1'b1;
                    end
                end else begin
                    cycle_counter = cycle_counter - 1;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                    done = 1'b0;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            counting <= (state == COUNTING);
            done <= (state == DONE);
        end
    end

endmodule