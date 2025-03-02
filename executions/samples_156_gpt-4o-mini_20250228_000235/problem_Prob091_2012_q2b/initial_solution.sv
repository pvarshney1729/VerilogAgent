module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    logic [5:0] next_state;

    // Combinational logic for next state
    always @(*) begin
        case (y)
            6'b000001: next_state = (w) ? 6'b000010 : 6'b000001; // State A
            6'b000010: next_state = (w) ? 6'b000100 : 6'b001000; // State B
            6'b000100: next_state = (w) ? 6'b010000 : 6'b001000; // State C
            6'b001000: next_state = (w) ? 6'b100000 : 6'b000001; // State D
            6'b010000: next_state = (w) ? 6'b010000 : 6'b001000; // State E
            6'b100000: next_state = (w) ? 6'b000100 : 6'b001000; // State F
            default: next_state = 6'b000001; // Default to state A
        endcase
    end

    // Output logic
    assign Y1 = y[1]; // Output Y1 is the input of state flip-flop y[1]
    assign Y3 = y[3]; // Output Y3 is the input of state flip-flop y[3]

endmodule