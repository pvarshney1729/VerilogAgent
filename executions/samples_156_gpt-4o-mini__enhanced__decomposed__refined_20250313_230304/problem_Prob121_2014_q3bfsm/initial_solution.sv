[BEGIN]
module TopModule (
    input logic clk,            // Clock input (positive edge triggered)
    input logic reset,          // Synchronous active-high reset
    input logic x,              // Input signal (one bit, unsigned)
    output logic z              // Output signal (one bit, unsigned)
);
    logic [2:0] y; // State register

    always @(posedge clk) begin
        if (reset) begin
            y <= 3'b000; // Reset to state 000
            z <= 1'b0;   // Initialize output z to 0
        end else begin
            case (y)
                3'b000: y <= (x) ? 3'b001 : 3'b000; // Next state
                3'b001: y <= (x) ? 3'b100 : 3'b001; // Next state
                3'b010: y <= (x) ? 3'b001 : 3'b010; // Next state
                3'b011: y <= (x) ? 3'b010 : 3'b001; // Next state
                3'b100: y <= (x) ? 3'b100 : 3'b011; // Next state
                default: y <= 3'b000;               // Default case
            endcase
        end
    end

    always @(*) begin
        case (y)
            3'b000: z = 1'b0; // Output for state 000
            3'b001: z = 1'b0; // Output for state 001
            3'b010: z = 1'b0; // Output for state 010
            3'b011: z = 1'b1; // Output for state 011
            3'b100: z = 1'b1; // Output for state 100
            default: z = 1'b0; // Default output
        endcase
    end
endmodule
[DONE]