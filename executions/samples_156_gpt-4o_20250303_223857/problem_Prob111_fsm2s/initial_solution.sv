module TopModule (
    input logic clk,    // Clock signal, positive-edge triggered
    input logic reset,  // Active-high, synchronous reset
    input logic j,      // Input control signal for state transitions
    input logic k,      // Input control signal for state transitions
    output logic out    // Output signal, determined by the current state of the state machine
);

    // State encoding
    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end

    // Sequential logic for state update and output logic
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= OFF;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule