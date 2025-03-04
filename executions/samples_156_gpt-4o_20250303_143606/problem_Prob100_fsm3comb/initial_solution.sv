module TopModule (
    input logic clk,            // Clock signal for sequential logic
    input logic rst_n,          // Active low reset signal
    input logic in,             // Single-bit input
    input logic [1:0] state,    // Current state input (2 bits)
    output logic [1:0] next_state, // Next state output (2 bits, registered for stability)
    output logic out            // Output (1 bit, derived from state)
);

    always @(*) begin
        // Default assignments
        next_state = 2'b00;
        out = 1'b0;

        // State transition and output logic
        case (state)
            2'b00: begin // State A
                if (in) begin
                    next_state = 2'b01; // Transition to State B
                end else begin
                    next_state = 2'b00; // Remain in State A
                end
            end
            2'b01: begin // State B
                if (in) begin
                    next_state = 2'b01; // Remain in State B
                end else begin
                    next_state = 2'b10; // Transition to State C
                end
            end
            2'b10: begin // State C
                if (in) begin
                    next_state = 2'b11; // Transition to State D
                end else begin
                    next_state = 2'b00; // Transition to State A
                end
            end
            2'b11: begin // State D
                out = 1'b1; // Output is 1
                if (in) begin
                    next_state = 2'b01; // Transition to State B
                end else begin
                    next_state = 2'b10; // Transition to State C
                end
            end
            default: begin
                next_state = 2'b00; // Default to State A
            end
        endcase
    end

endmodule