```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        ENABLE_1 = 2'b01,
        ENABLE_2 = 2'b10,
        ENABLE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= ENABLE_1;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (/* pattern detection condition */) begin
                    next_state = ENABLE_1;
                end else begin
                    next_state = IDLE;
                end
            end
            ENABLE_1: next_state = ENABLE_2;
            ENABLE_2: next_state = ENABLE_3;
            ENABLE_3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            ENABLE_1, ENABLE_2, ENABLE_3: shift_ena = 1'b1;
            default: shift_ena = 1'b0;
        endcase
    end

endmodule
```