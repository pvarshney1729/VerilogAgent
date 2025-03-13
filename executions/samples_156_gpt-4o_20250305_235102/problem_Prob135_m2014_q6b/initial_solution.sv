module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic rst,
    output logic Y1
);

    logic [2:0] state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            3'b000: next_state = (w == 0) ? 3'b001 : 3'b000; // State A
            3'b001: next_state = (w == 0) ? 3'b010 : 3'b011; // State B
            3'b010: next_state = (w == 0) ? 3'b100 : 3'b011; // State C
            3'b011: next_state = (w == 0) ? 3'b101 : 3'b000; // State D
            3'b100: next_state = (w == 0) ? 3'b100 : 3'b011; // State E
            3'b101: next_state = (w == 0) ? 3'b010 : 3'b011; // State F
            default: next_state = 3'b000; // Default to State A
        endcase
    end

    // State Register with Synchronous Reset
    always @(posedge clk) begin
        if (rst)
            state <= 3'b000; // Reset to State A
        else
            state <= next_state;
    end

    // Output Logic
    assign Y1 = state[1];

endmodule