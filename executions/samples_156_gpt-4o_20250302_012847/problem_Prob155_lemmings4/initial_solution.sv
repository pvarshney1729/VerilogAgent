```verilog
module fsm_example (
    input logic clk,
    input logic reset,
    input logic [1:0] in_signal,
    output logic [1:0] out_signal
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        out_signal = 2'b00;

        case (current_state)
            STATE_0: begin
                if (in_signal == 2'b01) begin
                    next_state = STATE_1;
                end
                out_signal = 2'b01;
            end
            STATE_1: begin
                if (in_signal == 2'b10) begin
                    next_state = STATE_2;
                end
                out_signal = 2'b10;
            end
            STATE_2: begin
                if (in_signal == 2'b11) begin
                    next_state = STATE_3;
                end
                out_signal = 2'b11;
            end
            STATE_3: begin
                if (in_signal == 2'b00) begin
                    next_state = STATE_0;
                end
                out_signal = 2'b00;
            end
            default: begin
                next_state = STATE_0;
                out_signal = 2'b00;
            end
        endcase
    end

endmodule
```