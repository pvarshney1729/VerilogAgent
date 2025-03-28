module TopModule (
    input  logic clk,
    input  logic aresetn,
    input  logic x,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // Detected '1'
        S2 = 2'b10  // Detected '10'
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset
    always_ff @(negedge aresetn or posedge clk) begin
        if (!aresetn) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always_ff @(*) begin
        // Default values
        next_state = current_state;
        z = 1'b0; // Default output

        case (current_state)
            S0: begin
                if (x) begin
                    next_state = S1; // Move to S1 on '1'
                end
            end
            
            S1: begin
                if (!x) begin
                    next_state = S2; // Move to S2 on '0'
                end else begin
                    // Remain in S1 if x is '1'
                end
            end
            
            S2: begin
                if (x) begin
                    z = 1'b1; // Output '1' on detecting "101"
                    next_state = S1; // Go back to S1 to check for overlapping sequences
                end else begin
                    next_state = S0; // Reset to S0 on '0'
                end
            end
            
            default: begin
                next_state = S0; // Fallback to initial state
            end
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly