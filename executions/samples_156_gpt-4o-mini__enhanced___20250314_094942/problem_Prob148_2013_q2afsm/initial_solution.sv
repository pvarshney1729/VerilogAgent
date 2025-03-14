module TopModule (
    input logic clk,             // Clock input
    input logic resetn,         // Active-low synchronous reset
    input logic [2:0] r,        // Input request signals from devices (3 bits)
    output logic [2:0] g        // Output grant signals to devices (3 bits)
);

// State encoding
typedef enum logic [1:0] {
    STATE_A = 2'b00,
    STATE_B = 2'b01,
    STATE_C = 2'b10,
    STATE_D = 2'b11
} state_t;

state_t current_state, next_state;

// Synchronous reset behavior
always @(posedge clk) begin
    if (!resetn) begin
        current_state <= STATE_A; // Reset to state A
        g <= 3'b000;               // Reset grants to 0
    end else begin
        current_state <= next_state; // Update state on clock edge
    end
end

// FSM state transition logic
always @(*) begin
    // Default values
    next_state = current_state;  
    g = 3'b000;                  // Default grant output

    case (current_state)
        STATE_A: begin
            if (r[0]) begin
                next_state = STATE_B; // Grant to device 0
                g[0] = 1'b1;
            end else if (r[1]) begin
                next_state = STATE_C; // Grant to device 1
                g[1] = 1'b1;
            end else if (r[2]) begin
                next_state = STATE_D; // Grant to device 2
                g[2] = 1'b1;
            end
        end
        STATE_B: begin
            if (r[0]) begin
                next_state = STATE_B; // Remain in state B
                g[0] = 1'b1;           // Grant to device 0
            end else begin
                next_state = STATE_A; // Return to state A
            end
        end
        STATE_C: begin
            if (r[1]) begin
                next_state = STATE_C; // Remain in state C
                g[1] = 1'b1;           // Grant to device 1
            end else begin
                next_state = STATE_A; // Return to state A
            end
        end
        STATE_D: begin
            // Additional logic for STATE_D if needed
            next_state = STATE_A; // Default return to state A
        end
        default: begin
            next_state = STATE_A; // Fallback to state A
        end
    endcase
end

endmodule