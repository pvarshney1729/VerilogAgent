[BEGIN]
module TopModule (
    input logic [2:0] y,    
    input logic w,          
    input logic reset,      // Synchronous reset input
    input logic clk,        // Clock input
    output logic Y1         
);
    logic [2:0] state; // Current state register

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // Initialize to state A (000)
        end else begin
            case (state)
                3'b000: state <= (w == 1'b0) ? 3'b001 : 3'b000; // A
                3'b001: state <= (w == 1'b0) ? 3'b010 : 3'b011; // B
                3'b010: state <= (w == 1'b0) ? 3'b100 : 3'b011; // C
                3'b011: state <= (w == 1'b0) ? 3'b101 : 3'b000; // D
                3'b100: state <= (w == 1'b0) ? 3'b100 : 3'b011; // E
                3'b101: state <= (w == 1'b0) ? 3'b010 : 3'b011; // F
                default: state <= 3'b000; // Default case to reset state
            endcase
        end
    end

    // Combinational logic for output Y1 based on state
    always @(*) begin
        Y1 = state[1]; // Output Y1 as the second bit of the state
    end

endmodule
[DONE]