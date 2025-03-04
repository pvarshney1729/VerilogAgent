```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        ENABLE1 = 2'b01,
        ENABLE2 = 2'b10,
        ENABLE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] cycle_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= ENABLE1;
            cycle_count <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state != IDLE) begin
                cycle_count <= cycle_count + 1;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (reset) begin
                    next_state = ENABLE1;
                end
            end
            ENABLE1: begin
                if (cycle_count == 2'b11) begin
                    next_state = IDLE;
                end else begin
                    next_state = ENABLE1;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        shift_ena = (current_state != IDLE);
    end

endmodule
```