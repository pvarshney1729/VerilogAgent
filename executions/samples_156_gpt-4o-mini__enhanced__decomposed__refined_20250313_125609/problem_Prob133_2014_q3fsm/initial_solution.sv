[BEGIN]
```verilog
module TopModule (
    input  logic clk,       // Clock signal (positive edge triggered)
    input  logic reset,     // Active high synchronous reset
    input  logic s,         // Control signal for state transitions
    input  logic w,         // Input signal to be evaluated
    output logic z          // Output signal indicating result
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [2:0] w_count; // Counter for w = 1 occurrences
    logic [1:0] cycle;   // To track the current cycle (0, 1, 2)

    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            z <= 1'b0;
            w_count <= 3'b000;
            cycle <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                if (cycle < 2'b11) begin
                    w_count <= {w_count[1:0], w}; // Shift in current w value
                    cycle <= cycle + 2'b01;      // Increment cycle count
                end else begin
                    // After three cycles, check the count
                    if (w_count[2] + w_count[1] + w_count[0] == 3'b010) begin
                        z <= 1'b1; // Set z to 1 if w = 1 occurred exactly twice
                    end else begin
                        z <= 1'b0; // Set z to 0 otherwise
                    end
                    // Reset for the next evaluation
                    w_count <= {1'b0, w}; // Shift in current w for next evaluation
                    cycle <= 2'b01; // Restart cycle count
                end
            end
        end
    end

    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                    w_count = 3'b000; // Reset count when moving to State B
                    cycle = 2'b00;    // Reset cycle count
                end else begin
                    next_state = STATE_A;
                end
            end
            
            STATE_B: begin
                next_state = STATE_B; // Stay in State B
            end
            
            default: begin
                next_state = STATE_A; // Default to State A
            end
        endcase
    end
endmodule
```
[DONE]