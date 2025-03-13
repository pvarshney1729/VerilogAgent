[BEGIN]
module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic reset,        // Synchronous active-high reset
    input logic x,           // Input signal x, 1-bit width
    output logic z           // Output signal z, 1-bit width
);

    // State declaration
    logic [2:0] y;           // Current state, 3 bits wide

    // State encoding
    parameter STATE_000 = 3'b000,
              STATE_001 = 3'b001,
              STATE_010 = 3'b010,
              STATE_011 = 3'b011,
              STATE_100 = 3'b100;

    // State Transition Logic
    always @(posedge clk) begin
        if (reset) begin
            y <= STATE_000;   // Reset to state 000
            z <= 1'b0;        // Initialize output z to 0 on reset
        end else begin
            case (y)
                STATE_000: begin
                    if (x) begin
                        y <= STATE_001; // Transition to state 001 if x=1
                    end 
                    z <= 1'b0; // Output z is 0
                end
                STATE_001: begin
                    if (x) begin
                        y <= STATE_100; // Transition to state 100 if x=1
                    end 
                    z <= 1'b0; // Output z is 0
                end
                STATE_010: begin
                    if (x) begin
                        y <= STATE_001; // Transition to state 001 if x=1
                    end 
                    z <= 1'b0; // Output z is 0
                end
                STATE_011: begin
                    if (x) begin
                        y <= STATE_010; // Transition to state 010 if x=1
                    end else begin
                        y <= STATE_001; // Transition to state 001 if x=0
                    end
                    z <= 1'b1; // Output z is 1
                end
                STATE_100: begin
                    if (x) begin
                        y <= STATE_100; // Remain in state 100 if x=1
                    end else begin
                        y <= STATE_011; // Transition to state 011 if x=0
                    end
                    z <= 1'b1; // Output z is 1
                end
                default: begin
                    y <= STATE_000;   // Default to state 000 for any undefined state
                    z <= 1'b0;        // Output z is 0
                end
            endcase
        end
    end

endmodule
[DONE]