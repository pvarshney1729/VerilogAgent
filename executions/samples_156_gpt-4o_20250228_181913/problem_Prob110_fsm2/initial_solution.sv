```verilog
module TopModule (
    input logic clk,       // Clock signal, positive-edge triggered
    input logic areset,    // Active-high asynchronous reset
    input logic j,         // Input signal for state transition from OFF to ON
    input logic k,         // Input signal for state transition from ON to OFF
    output logic out       // Output signal, reflecting the state of the machine
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

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= OFF;
        else
            current_state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b0;
        else
            out <= (current_state == ON) ? 1'b1 : 1'b0;
    end

endmodule
```