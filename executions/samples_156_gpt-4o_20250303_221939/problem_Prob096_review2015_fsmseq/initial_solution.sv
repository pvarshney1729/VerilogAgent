```verilog
module TopModule(
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);

    typedef enum logic [2:0] {
        STATE_0     = 3'b000,
        STATE_1     = 3'b001,
        STATE_2     = 3'b010,
        STATE_3     = 3'b011,
        STATE_FOUND = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_0;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_FOUND) begin
                start_shifting <= 1'b1;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_0: begin
                if (data) next_state = STATE_1;
                else next_state = STATE_0;
            end
            STATE_1: begin
                if (data) next_state = STATE_2;
                else next_state = STATE_0;
            end
            STATE_2: begin
                if (data) next_state = STATE_2;
                else next_state = STATE_3;
            end
            STATE_3: begin
                if (data) next_state = STATE_FOUND;
                else next_state = STATE_0;
            end
            STATE_FOUND: begin
                next_state = STATE_FOUND;
            end
            default: begin
                next_state = STATE_0;
            end
        endcase
    end

endmodule
```