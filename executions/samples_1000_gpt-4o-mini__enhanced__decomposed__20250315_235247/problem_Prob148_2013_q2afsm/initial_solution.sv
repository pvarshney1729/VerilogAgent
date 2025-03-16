module TopModule (
    input logic clk,
    input logic resetn,
    input logic [2:0] r,
    output logic [2:0] g
);
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (!resetn)
            current_state <= A; // Reset to state A
        else
            current_state <= next_state; // Update to next state
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: begin
                if (r[0]) 
                    next_state = B; // Grant to device 0
                else if (r[1]) 
                    next_state = C; // Grant to device 1
                else if (r[2]) 
                    next_state = D; // Grant to device 2
                else 
                    next_state = A; // Stay in state A
            end
            B: begin
                if (r[0]) 
                    next_state = B; // Stay in state B
                else 
                    next_state = A; // Go back to state A
            end
            C: begin
                if (r[1]) 
                    next_state = C; // Stay in state C
                else 
                    next_state = A; // Go back to state A
            end
            D: begin
                next_state = A; // Go back to state A from D
            end
            default: next_state = A; // Default to state A
        endcase
    end

    // Output logic
    always @(*) begin
        g = 3'b000; // Default output
        case (current_state)
            B: g[0] = 1'b1; // Grant for device 0
            C: g[1] = 1'b1; // Grant for device 1
            D: g[2] = 1'b1; // Grant for device 2
            default: g = 3'b000; // No grants
        endcase
    end
endmodule