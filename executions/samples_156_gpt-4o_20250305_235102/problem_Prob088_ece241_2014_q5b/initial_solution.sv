```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        STATE_A = 2'b01,
        STATE_B = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic with synchronous reset
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        next_state = current_state; // Default to current state
        z = 1'b0; // Default output
        case (current_state)
            STATE_A: begin
                if (x) begin
                    next_state = STATE_B;
                    z = 1'b1;
                end
            end
            STATE_B: begin
                if (x) begin
                    z = 1'b0;
                end else begin
                    z = 1'b1;
                end
            end
        endcase
    end

endmodule
[DONE]
```