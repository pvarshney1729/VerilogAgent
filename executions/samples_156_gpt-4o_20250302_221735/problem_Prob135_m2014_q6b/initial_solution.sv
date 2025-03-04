module TopModule (
    input logic [2:0] y,  // 3-bit input representing the current state
    input logic w,        // 1-bit input
    input logic clk,      // Clock signal
    input logic reset_n,  // Asynchronous active-low reset
    output logic Y1       // 1-bit output, equal to y[1]
);

    logic [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            3'b000: next_state = (w == 1'b0) ? 3'b001 : 3'b000; // State A
            3'b001: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // State B
            3'b010: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // State C
            3'b011: next_state = (w == 1'b0) ? 3'b101 : 3'b000; // State D
            3'b100: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // State E
            3'b101: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // State F
            default: next_state = 3'b000; // Default to State A
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= 3'b000; // Reset to State A
        else
            state <= next_state;
    end

    // Output logic
    assign Y1 = state[1];

endmodule