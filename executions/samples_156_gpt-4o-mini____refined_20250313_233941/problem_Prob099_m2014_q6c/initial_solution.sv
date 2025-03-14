module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    logic [5:0] next_state;

    // Next-state logic for Y2 and Y4 based on the state machine
    always @(*) begin
        case (y)
            6'b000001: next_state = (w) ? 6'b000001 : 6'b000010; // State A
            6'b000010: next_state = (w) ? 6'b001000 : 6'b000100; // State B
            6'b000100: next_state = (w) ? 6'b001000 : 6'b001000; // State C
            6'b001000: next_state = (w) ? 6'b000001 : 6'b010000; // State D
            6'b010000: next_state = (w) ? 6'b001000 : 6'b010000; // State E
            6'b100000: next_state = (w) ? 6'b001000 : 6'b000100; // State F
            default: next_state = 6'b000001; // Default to state A
        endcase
    end

    // Output logic for Y1 and Y3
    assign Y1 = y[1]; // Corresponds to state B
    assign Y3 = y[3]; // Corresponds to state D

endmodule