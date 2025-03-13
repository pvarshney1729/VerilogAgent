```verilog
[BEGIN]
module TopModule (
    input logic clk,         // Clock signal, rising-edge triggered
    input logic areset,      // Asynchronous active-high reset
    input logic j,           // Input for transitioning from OFF to ON
    input logic k,           // Input for transitioning from ON to OFF
    output logic out         // Output, 1-bit, indicates current state
);

    // State encoding
    localparam OFF = 1'b0;
    localparam ON  = 1'b1;

    logic state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (areset) 
            state <= OFF;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            OFF: next_state = (j) ? ON : OFF;
            ON:  next_state = (k) ? OFF : ON;
            default: next_state = OFF; // default to OFF for safety
        endcase
    end

    // Output logic
    always @(*) begin
        out = (state == ON) ? 1'b1 : 1'b0;
    end

endmodule
[DONE]
```