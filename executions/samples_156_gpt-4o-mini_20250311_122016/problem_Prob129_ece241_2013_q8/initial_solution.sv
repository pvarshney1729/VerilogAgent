```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_0 = 2'b00,  // Initial state
        STATE_1 = 2'b01,  // Detected "1"
        STATE_2 = 2'b10   // Detected "10"
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= STATE_0;
            z <= 1'b0; // Deassert output z on reset
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        z = 1'b0;

        case (current_state)
            STATE_0: begin
                if (x)
                    next_state = STATE_1;
            end
            STATE_1: begin
                if (!x)
                    next_state = STATE_2;
            end
            STATE_2: begin
                if (x) begin
                    next_state = STATE_1;
                    z = 1'b1; // Detect "101"
                end else begin
                    next_state = STATE_0;
                end
            end
            default: next_state = STATE_0;
        endcase
    end

endmodule
[DONE]
```