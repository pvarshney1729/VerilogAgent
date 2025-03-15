module TopModule(
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);
    // Derive next-state logic for Y2 (y[1]) and Y4 (y[3])
    logic [5:0] next_state;

    always @(*) begin
        // Default all next states to 0
        next_state = 6'b000000;
        
        // State transitions based on the current state and input 'w'
        case (y)
            6'b000001: next_state = w ? 6'b000001 : 6'b000010; // State A
            6'b000010: next_state = w ? 6'b001000 : 6'b000100; // State B
            6'b000100: next_state = w ? 6'b001000 : 6'b010000; // State C
            6'b001000: next_state = w ? 6'b000001 : 6'b100000; // State D
            6'b010000: next_state = w ? 6'b001000 : 6'b010000; // State E
            6'b100000: next_state = w ? 6'b001000 : 6'b000100; // State F
            default:   next_state = 6'b000001; // Default to State A on invalid state
        endcase
    end

    // Derive Y2 and Y4 from next_state
    assign Y1 = next_state[0];
    assign Y3 = next_state[2];

endmodule