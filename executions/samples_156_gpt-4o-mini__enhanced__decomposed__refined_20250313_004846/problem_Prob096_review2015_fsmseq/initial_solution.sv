```
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        DETECTED = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transitions and output
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DETECTED) begin
                start_shifting <= 1'b1;
            end else begin
                start_shifting <= 1'b0; // Reset start_shifting when not in DETECTED
            end
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (current_state)
            IDLE: 
                next_state = data ? S1 : IDLE;
            S1: 
                next_state = data ? S11 : IDLE;
            S11: 
                next_state = !data ? S110 : S11;
            S110: 
                next_state = data ? DETECTED : IDLE;
            DETECTED: 
                next_state = DETECTED;
            default: 
                next_state = IDLE;
        endcase
    end

endmodule
[DONE]
```