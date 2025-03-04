module TopModule (
    input logic [5:0] y,       // 6-bit state vector, unsigned
    input logic w,             // 1-bit input for FSM transitions
    output logic Y1,           // Output corresponding to the next state of y[1]
    output logic Y3,           // Output corresponding to the next state of y[3]
    input logic clk,           // Clock signal for state transitions
    input logic reset          // Asynchronous reset signal
);

    logic [5:0] state, next_state;

    // State transition logic
    always @(*) begin
        next_state = 6'b000001; // Default to state A
        case (state)
            6'b000001: next_state = (w) ? 6'b000010 : 6'b000001; // A -> B or A
            6'b000010: next_state = (w) ? 6'b000100 : 6'b001000; // B -> C or D
            6'b000100: next_state = (w) ? 6'b010000 : 6'b001000; // C -> E or D
            6'b001000: next_state = (w) ? 6'b100000 : 6'b000001; // D -> F or A
            6'b010000: next_state = (w) ? 6'b010000 : 6'b001000; // E -> E or D
            6'b100000: next_state = (w) ? 6'b000100 : 6'b001000; // F -> C or D
            default:   next_state = 6'b000001; // Undefined states go to A
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= 6'b000001; // Reset to state A
        else
            state <= next_state;
    end

    // Output logic
    assign Y1 = next_state[1];
    assign Y3 = next_state[3];

endmodule