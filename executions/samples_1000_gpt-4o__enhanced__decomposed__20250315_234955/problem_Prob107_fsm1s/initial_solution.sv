module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    // State encoding
    localparam logic STATE_A = 1'b0;
    localparam logic STATE_B = 1'b1;

    // State register
    logic current_state, next_state;

    // State transition logic with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B; // Reset state is B
        end else begin
            current_state <= next_state;
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
            default: begin
                next_state = STATE_B; // Default to state B
            end
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
            default: out = 1'b1; // Default output for safety
        endcase
    end

endmodule