module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic rst,
    output logic Y1
);

    logic [2:0] next_state;

    // Next state logic
    always @(*) begin
        case (y)
            3'b000: next_state = (w == 0) ? 3'b001 : 3'b000; // State A
            3'b001: next_state = (w == 0) ? 3'b010 : 3'b011; // State B
            3'b010: next_state = (w == 0) ? 3'b100 : 3'b011; // State C
            3'b011: next_state = (w == 0) ? 3'b101 : 3'b000; // State D
            3'b100: next_state = (w == 0) ? 3'b100 : 3'b011; // State E
            3'b101: next_state = (w == 0) ? 3'b010 : 3'b011; // State F
            default: next_state = 3'b000; // Default to State A for undefined states
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            y <= 3'b000; // Reset to State A
        else
            y <= next_state;
    end

    // Output logic
    assign Y1 = y[1];

endmodule