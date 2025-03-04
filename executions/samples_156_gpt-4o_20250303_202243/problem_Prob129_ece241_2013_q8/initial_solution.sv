module TopModule (
    input  logic clk,       // Clock signal
    input  logic aresetn,   // Active-low asynchronous reset
    input  logic x,         // Input signal to be analyzed
    output logic z          // Output signal, asserted when "101" is detected
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state, waiting for '1'
        S1 = 2'b01, // Detected '1', waiting for '0'
        S2 = 2'b10  // Detected '10', waiting for final '1'
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        z = 1'b0; // Default output

        case (current_state)
            S0: begin
                if (x == 1'b1) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (x == 1'b0) begin
                    next_state = S2;
                end
            end
            S2: begin
                if (x == 1'b1) begin
                    next_state = S1;
                    z = 1'b1; // Sequence "101" detected
                end else begin
                    next_state = S0;
                end
            end
            default: begin
                next_state = S0;
            end
        endcase
    end

endmodule