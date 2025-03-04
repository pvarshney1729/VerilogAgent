module TopModule (
    input logic clk,        // Clock signal, positive edge-triggered
    input logic reset,      // Active-high synchronous reset
    input logic j,          // Input signal j
    input logic k,          // Input signal k
    output logic out        // Output signal out
);

    typedef enum logic [0:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            OFF: begin
                if (j == 1'b1)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k == 1'b1)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= OFF;
        else
            current_state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk) begin
        out <= (current_state == ON) ? 1'b1 : 1'b0;
    end

endmodule