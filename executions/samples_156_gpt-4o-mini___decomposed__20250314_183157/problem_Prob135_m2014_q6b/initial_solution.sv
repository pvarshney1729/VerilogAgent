module TopModule (
    input  logic [2:0] y,
    input  logic       w,
    output logic       Y1
);

logic [2:0] state, next_state;

// Flip-flops to hold the current state of the FSM
always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // Reset to state A
    end else begin
        state <= next_state; // Update to next state
    end
end

// Next-state logic
always @(*) begin
    case (state)
        3'b000: next_state = (w == 1'b0) ? 3'b001 : 3'b000; // A
        3'b001: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // B
        3'b010: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // C
        3'b011: next_state = (w == 1'b0) ? 3'b101 : 3'b000; // D
        3'b100: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // E
        3'b101: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // F
        default: next_state = 3'b000; // Default to state A
    endcase
end

// Output logic for Y1
assign Y1 = (state == 3'b000 && w == 1'b0) ? 1'b0 : // A (0) --0--> B
            (state == 3'b000 && w == 1'b1) ? 1'b0 : // A (0) --1--> A
            (state == 3'b001 && w == 1'b0) ? 1'b0 : // B (0) --0--> C
            (state == 3'b001 && w == 1'b1) ? 1'b0 : // B (0) --1--> D
            (state == 3'b010 && w == 1'b0) ? 1'b1 : // C (0) --0--> E
            (state == 3'b010 && w == 1'b1) ? 1'b0 : // C (0) --1--> D
            (state == 3'b011 && w == 1'b0) ? 1'b1 : // D (0) --0--> F
            (state == 3'b011 && w == 1'b1) ? 1'b0 : // D (0) --1--> A
            (state == 3'b100 && w == 1'b0) ? 1'b1 : // E (1) --0--> E
            (state == 3'b100 && w == 1'b1) ? 1'b0 : // E (1) --1--> D
            (state == 3'b101 && w == 1'b0) ? 1'b1 : // F (1) --0--> C
            (state == 3'b101 && w == 1'b1) ? 1'b0 : // F (1) --1--> D
            1'bx; // undefined state

endmodule