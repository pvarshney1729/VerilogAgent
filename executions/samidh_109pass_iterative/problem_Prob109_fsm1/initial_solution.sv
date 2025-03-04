module TopModule (
    input logic clk,       // Clock signal, 1-bit
    input logic areset,    // Asynchronous reset signal, active high, 1-bit
    input logic in,        // Input signal, 1-bit
    output logic out       // Output signal, 1-bit
);

    // State encoding
    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_B; // Handle undefined states
        endcase
    end

    // Sequential logic for state transition and output
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1; // Default to State B output
        endcase
    end

endmodule