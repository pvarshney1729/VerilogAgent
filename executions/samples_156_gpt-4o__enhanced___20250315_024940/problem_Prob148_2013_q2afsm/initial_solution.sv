module TopModule (
    input clk,
    input resetn,
    input [2:0] r,
    output logic [2:0] g
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    // State variable
    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (~resetn) begin
            current_state <= A; // Reset to state A
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Combinational logic for next state generation
    always @(*) begin
        // Default to hold the current state
        next_state = current_state;
        case (current_state)
            A: begin
                if (r[0]) begin
                    next_state = B; // Transition to B if r[0] is high
                end else if (~r[0] && r[1]) begin
                    next_state = C; // Transition to C if r[1] is high
                end else if (~r[0] && ~r[1] && ~r[2]) begin
                    next_state = D; // Transition to D if all are low
                end
            end
            B: begin
                if (~r[0]) begin
                    next_state = A; // Transition back to A if r[0] is low
                end // Stay in B if r[0] is high
            end
            C: begin
                if (~r[1]) begin
                    next_state = A; // Transition back to A if r[1] is low
                end // Stay in C if r[1] is high
            end
            D: begin
                if (~r[0] && ~r[1] && r[2]) begin
                    next_state = D; // Stay in D if only r[2] is high
                end else begin
                    next_state = A; // Transition back to A if no requests
                end
            end
        endcase
    end

    // Output logic
    always @(*) begin
        // Default outputs to 0
        g = 3'b000;
        case (current_state)
            B: g[0] = 1; // Grant to device 0
            C: g[1] = 1; // Grant to device 1
            // No grants for state A or D
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly