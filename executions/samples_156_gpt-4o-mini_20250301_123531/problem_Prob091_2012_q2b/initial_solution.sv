module TopModule (
    input logic clk,
    input logic reset_n,
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    logic [5:0] state, next_state;

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (!reset_n) begin
            state <= 6'b000001; // Reset to state A
        end else begin
            state <= next_state; // Transition to next state
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            6'b000001: next_state = (w) ? 6'b000010 : 6'b000001; // State A
            6'b000010: next_state = (w) ? 6'b000100 : 6'b001000; // State B
            6'b000100: next_state = (w) ? 6'b010000 : 6'b001000; // State C
            6'b001000: next_state = (w) ? 6'b100000 : 6'b000001; // State D
            6'b010000: next_state = (w) ? 6'b010000 : 6'b001000; // State E
            6'b100000: next_state = (w) ? 6'b000100 : 6'b001000; // State F
            default:   next_state = 6'b000001; // Default to state A for illegal states
        endcase
    end

    // Output logic
    assign Y1 = (next_state == 6'b000010); // State B
    assign Y3 = (next_state == 6'b001000); // State D

endmodule