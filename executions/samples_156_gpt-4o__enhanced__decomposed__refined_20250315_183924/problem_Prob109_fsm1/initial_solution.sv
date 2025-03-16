module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding
    typedef enum logic [0:0] {
        STATE_A = 1'b0,  // Outputs '0'
        STATE_B = 1'b1   // Outputs '1'
    } state_t;

    state_t current_state, next_state;

    // State transition and output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_B;  // Asynchronous reset to STATE_B
        end else begin
            current_state <= next_state;  // State transition on clock edge
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_B: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_A: begin
                if (in == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_B; // Safety default
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
            default: out = 1'b1; // Default to STATE_B output
        endcase
    end

endmodule