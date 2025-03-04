module TopModule (
    input logic clk,       // 1-bit clock input, positive edge-triggered
    input logic areset,    // 1-bit active-high asynchronous reset
    input logic j,         // 1-bit input for state transition
    input logic k,         // 1-bit input for state transition
    output logic out       // 1-bit output reflecting the current state
);

    typedef enum logic {OFF, ON} state_t;
    state_t state, next_state;

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
            out <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: next_state = OFF; // Default case for safety
        endcase
    end

    // Output logic
    always_comb begin
        out = (state == ON);
    end

endmodule