[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset, // Active high, synchronous reset
    input logic s,
    input logic w,
    output logic z // Registered output
);

    typedef enum logic {1'b0, 1'b1} state_t; // Explicit size for enum
    state_t current_state, next_state;
    logic [1:0] count_w; // Counter for w = 1 occurrences
    logic [1:0] cycle_count; // Counter for clock cycles in state B

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= 1'b0; // Set to state A
            z <= 1'b0; // Reset output
            count_w <= 2'b00; // Reset count for w
            cycle_count <= 2'b00; // Reset cycle count
        end else begin
            current_state <= next_state;
            if (current_state == 1'b1) begin // In state B
                if (cycle_count < 2'b11) begin // Less than 3 cycles
                    if (w) count_w <= count_w + 1; // Count occurrences of w
                    cycle_count <= cycle_count + 1; // Increment cycle count
                end else begin
                    z <= (count_w == 2'b10) ? 1'b1 : 1'b0; // Set z based on count_w
                    cycle_count <= 2'b00; // Reset cycle count for next sequence
                    count_w <= 2'b00; // Reset count for next sequence
                end
            end
        end
    end

    always_comb begin
        case (current_state)
            1'b0: begin // State A
                if (s) begin
                    next_state = 1'b1; // Transition to state B
                end else begin
                    next_state = 1'b0; // Stay in state A
                end
            end
            1'b1: begin // State B
                next_state = 1'b1; // Stay in state B
            end
            default: next_state = 1'b0; // Default case
        endcase
    end

endmodule
```
[DONE]