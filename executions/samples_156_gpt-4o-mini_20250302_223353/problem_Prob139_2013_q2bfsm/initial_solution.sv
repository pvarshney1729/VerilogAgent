module TopModule (
    input logic clk,        // Clock signal, positive edge triggered
    input logic resetn,     // Reset signal, synchronous active low
    input logic x,          // Input signal from motor
    input logic y,          // Input signal from motor
    output logic f,         // Output control signal to motor
    output logic g          // Output control signal to motor
);

    // State Definitions
    typedef enum logic [2:0] {
        STATE_A,           // Initial state when reset is asserted
        STATE_B,           // State after f is set to 1
        STATE_C,           // State monitoring x for sequence 101
        STATE_D,           // State after detecting 101, monitoring y
        STATE_G_SET,       // State where g is permanently set to 1
        STATE_G_RESET      // State where g is permanently set to 0
    } state_t;

    state_t current_state, next_state;

    // Initial conditions
    initial begin
        current_state = STATE_A;
        f = 1'b0;
        g = 1'b0;
    end

    // Sequential Logic: State Transition
    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational Logic: Next State Logic and Output Logic
    always @(*) begin
        // Default assignments for outputs
        next_state = current_state;
        f = 1'b0; // Default to 0 unless specified by state logic
        g = (current_state == STATE_G_SET) ? 1'b1 : 1'b0;

        case (current_state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    f = 1'b1; // Set f to 1 for one clock cycle
                    next_state = STATE_B;
                end
            end

            STATE_B: begin
                next_state = STATE_C; // Move to monitoring x sequence
            end

            STATE_C: begin
                if (x == 1'b1) begin
                    next_state = STATE_D; // Start monitoring y after detecting 101 sequence
                end
            end

            STATE_D: begin
                if (y == 1'b1) begin
                    next_state = STATE_G_SET; // Set g to 1 permanently
                end else begin
                    next_state = STATE_G_RESET; // Set g to 0 permanently if y is not 1 within two cycles
                end
            end

            STATE_G_SET: begin
                // Maintain g = 1
            end

            STATE_G_RESET: begin
                // Maintain g = 0
            end

            default: begin
                next_state = STATE_A; // Default to reset state
            end
        endcase
    end

endmodule