```verilog
[BEGIN]
module TopModule (
    input logic clk,          // Clock input
    input logic reset,        // Active high synchronous reset
    input logic data,         // Serial data input for pattern and duration
    input logic done_counting,// Signal indicating counters have finished
    input logic ack,          // Acknowledgment input from user
    output logic shift_ena,   // Output to enable data shift
    output logic counting,     // Output indicating counting state
    output logic done          // Output indicating timer completion
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        MATCH1  = 3'b001,
        MATCH2  = 3'b010,
        MATCH3  = 3'b011,
        MATCH4  = 3'b100,
        SHIFT   = 3'b101,
        COUNTING= 3'b110,
        DONE    = 3'b111
    } state_t;

    state_t state, next_state;
    logic [2:0] shift_counter;

    // State transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 3'b000;
        end else begin
            state <= next_state;
            if (state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 3'b000;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data) next_state = MATCH1;
            end
            MATCH1: begin
                if (data) next_state = MATCH2;
                else next_state = IDLE;
            end
            MATCH2: begin
                if (~data) next_state = MATCH3;
                else next_state = IDLE;
            end
            MATCH3: begin
                if (data) next_state = SHIFT;
                else next_state = IDLE;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'b011) next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1'b1;
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
[DONE]
```