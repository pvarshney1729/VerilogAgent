```verilog
[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    input logic pattern_detected,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        ENABLE_1 = 2'b01,
        ENABLE_2 = 2'b10,
        ENABLE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] enable_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            enable_counter <= 2'b00;
            shift_ena <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == ENABLE_1 || current_state == ENABLE_2 || current_state == ENABLE_3) begin
                enable_counter <= enable_counter + 1;
            end else begin
                enable_counter <= 2'b00;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;

        case (current_state)
            IDLE: begin
                if (pattern_detected) begin
                    next_state = ENABLE_1;
                end
            end
            ENABLE_1: begin
                shift_ena = 1'b1;
                if (enable_counter == 2'b01) begin
                    next_state = ENABLE_2;
                end
            end
            ENABLE_2: begin
                shift_ena = 1'b1;
                if (enable_counter == 2'b10) begin
                    next_state = ENABLE_3;
                end
            end
            ENABLE_3: begin
                shift_ena = 1'b1;
                if (enable_counter == 2'b11) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
[DONE]
```