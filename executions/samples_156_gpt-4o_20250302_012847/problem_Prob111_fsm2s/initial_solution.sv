module TopModule (
    input logic clk,        // Clock signal, 1-bit, active on rising edge
    input logic reset,      // Synchronous reset signal, 1-bit, active-high
    input logic j,          // Input signal J, 1-bit
    input logic k,          // Input signal K, 1-bit
    output logic out        // Output signal, 1-bit
);

    // State encoding
    typedef enum logic {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
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
            default: next_state = OFF;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule