[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        RESET,
        ENABLE_SHIFT,
        IDLE
    } state_t;

    state_t state, next_state;
    logic [2:0] cycle_count;

    always @(posedge clk) begin
        if (reset) begin
            state <= RESET;
            cycle_count <= 3'b000;
        end else begin
            state <= next_state;
            if (state == ENABLE_SHIFT) begin
                cycle_count <= cycle_count + 1;
            end
        end
    end

    always @(*) begin
        case (state)
            RESET: begin
                next_state = ENABLE_SHIFT;
            end
            ENABLE_SHIFT: begin
                if (cycle_count == 3'b011) // 4 cycles
                    next_state = IDLE;
                else
                    next_state = ENABLE_SHIFT;
            end
            IDLE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    assign shift_ena = (state == ENABLE_SHIFT);

endmodule
```
[DONE]