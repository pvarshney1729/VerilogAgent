```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SHIFT_ENABLE = 2'b01,
        HOLD = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [1:0] cycle_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            cycle_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT_ENABLE) begin
                cycle_counter <= cycle_counter + 1;
            end else begin
                cycle_counter <= 2'b00;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        case (current_state)
            IDLE: begin
                if (!reset) begin
                    next_state = SHIFT_ENABLE;
                end
            end
            SHIFT_ENABLE: begin
                shift_ena = 1'b1;
                if (cycle_counter == 2'b11) begin
                    next_state = HOLD;
                end
            end
            HOLD: begin
                if (reset) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
```