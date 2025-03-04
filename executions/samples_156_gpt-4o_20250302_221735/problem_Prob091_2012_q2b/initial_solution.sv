module TopModule (
    input logic [5:0] y,
    input logic w,
    input logic clk,
    input logic rst_n,
    output logic Y1,
    output logic Y3
);

    logic [5:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (y)
            6'b000001: next_state = (w) ? 6'b000010 : 6'b000001; // State A
            6'b000010: next_state = (w) ? 6'b000100 : 6'b001000; // State B
            6'b000100: next_state = (w) ? 6'b010000 : 6'b001000; // State C
            6'b001000: next_state = (w) ? 6'b100000 : 6'b000001; // State D
            6'b010000: next_state = (w) ? 6'b010000 : 6'b001000; // State E
            6'b100000: next_state = (w) ? 6'b000100 : 6'b001000; // State F
            default:   next_state = 6'b000001; // Default to State A
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= 6'b000001; // Reset to State A
        else
            state <= next_state;
    end

    // Output logic
    assign Y1 = (next_state == 6'b000010); // Transition to State B
    assign Y3 = (next_state == 6'b001000); // Transition to State D

endmodule