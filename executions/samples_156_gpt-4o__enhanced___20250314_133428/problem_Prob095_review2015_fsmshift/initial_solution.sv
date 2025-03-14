```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        SHIFT1 = 3'b001,
        SHIFT2 = 3'b010,
        SHIFT3 = 3'b011,
        SHIFT4 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= SHIFT1;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (reset) begin
                    next_state = SHIFT1;
                end else begin
                    next_state = IDLE;
                end
            end
            SHIFT1: next_state = SHIFT2;
            SHIFT2: next_state = SHIFT3;
            SHIFT3: next_state = SHIFT4;
            SHIFT4: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            SHIFT1, SHIFT2, SHIFT3, SHIFT4: shift_ena = 1'b1;
            default: shift_ena = 1'b0;
        endcase
    end

endmodule
```