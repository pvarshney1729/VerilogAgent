module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic rst_n,
    output logic Y1
);

    logic [2:0] state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!rst_n)
            state <= 3'b000; // Reset to State A
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            3'b000: next_state = (w == 1'b0) ? 3'b001 : 3'b000; // State A
            3'b001: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // State B
            3'b010: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // State C
            3'b011: next_state = (w == 1'b0) ? 3'b101 : 3'b000; // State D
            3'b100: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // State E
            3'b101: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // State F
            default: next_state = 3'b000; // Default to State A for invalid states
        endcase
    end

    // Output logic
    assign Y1 = state[1];

endmodule