[BEGIN]
module TopModule (
    input logic clk,               // Clock input
    input logic resetn,           // Active-low synchronous reset
    input logic [2:0] r,          // 3-bit request input (r[2:0])
    output logic [2:0] g           // 3-bit grant output (g[2:0])
);

typedef enum logic [1:0] {
    STATE_A = 2'b00,  // State A
    STATE_B = 2'b01,  // State B
    STATE_C = 2'b10,  // State C
    STATE_D = 2'b11   // State D
} state_t;

state_t current_state, next_state;  // State registers

// Timing Behavior
always_ff @(posedge clk) begin
    if (!resetn) begin
        current_state <= STATE_A;  // Reset to state A
        g <= 3'b000;                // Reset grants to 0
    end else begin
        current_state <= next_state; // Update current state
    end
end

// Next State Logic
always_comb begin
    // Default next state
    next_state = current_state;
    g = 3'b000;  // Default grant output

    case (current_state)
        STATE_A: begin
            if (r[0]) begin
                next_state = STATE_B;
                g[0] = 1'b1;  // Grant device 0
            end else if (r[1]) begin
                next_state = STATE_C;
                g[1] = 1'b1;  // Grant device 1
            end else if (r[2]) begin
                next_state = STATE_D;
                g[2] = 1'b1;  // Grant device 2
            end
        end
        STATE_B: begin
            if (r[0]) begin
                next_state = STATE_B; // Stay in B
                g[0] = 1'b1;  // Grant device 0
            end else begin
                next_state = STATE_A;
                g[0] = 1'b0;  // Revoke device 0 grant
            end
        end
        STATE_C: begin
            if (r[1]) begin
                next_state = STATE_C; // Stay in C
                g[1] = 1'b1;  // Grant device 1
            end else begin
                next_state = STATE_A;
                g[1] = 1'b0;  // Revoke device 1 grant
            end
        end
        STATE_D: begin
            next_state = STATE_A; // Default to state A
        end
    endcase
end

endmodule
[DONE]