```verilog
module TopModule (
    input  logic clk,        // Clock signal, positive edge-triggered
    input  logic reset,      // Synchronous active-high reset
    input  logic w,          // Input signal
    output logic z           // Output signal, 1-bit, unsigned
);

    // State Definitions
    parameter logic [2:0] STATE_A = 3'b000;
    parameter logic [2:0] STATE_B = 3'b001;
    parameter logic [2:0] STATE_C = 3'b010;
    parameter logic [2:0] STATE_D = 3'b011;
    parameter logic [2:0] STATE_E = 3'b100;
    parameter logic [2:0] STATE_F = 3'b101;

    logic [2:0] state, next_state;

    // State Transition Logic
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (w ? STATE_B : STATE_A);
            STATE_B: next_state = (w ? STATE_C : STATE_D);
            STATE_C: next_state = (w ? STATE_E : STATE_D);
            STATE_D: next_state = (w ? STATE_F : STATE_A);
            STATE_E: next_state = (w ? STATE_E : STATE_D);
            STATE_F: next_state = (w ? STATE_C : STATE_D);
            default: next_state = STATE_A; // Default for safety
        endcase
    end

    // Output Logic
    always @(*) begin
        case (state)
            STATE_E, STATE_F: z = 1;
            default: z = 0;
        endcase
    end

endmodule
```