```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        ACTIVE = 2'b01,
        WAIT = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [1:0] cycle_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= ACTIVE;
            cycle_count <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == ACTIVE) begin
                cycle_count <= cycle_count + 1;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;

        case (current_state)
            IDLE: begin
                if (reset) begin
                    next_state = ACTIVE;
                end
            end

            ACTIVE: begin
                shift_ena = 1'b1;
                if (cycle_count == 2'b11) begin
                    next_state = WAIT;
                end
            end

            WAIT: begin
                if (!reset) begin
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
```