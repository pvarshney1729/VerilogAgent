module TopModule (
    input logic [2:0] y,      // 3-bit input representing the current state
    input logic w,            // 1-bit input for state transition
    output logic Y1           // 1-bit output representing the y[1] bit of the state
);

    logic [2:0] next_state;

    // Combinational logic for next state
    always @(*) begin
        case (y)
            3'b000: next_state = (w) ? 3'b000 : 3'b001; // State A
            3'b001: next_state = (w) ? 3'b011 : 3'b010; // State B
            3'b010: next_state = (w) ? 3'b011 : 3'b100; // State C
            3'b011: next_state = (w) ? 3'b000 : 3'b101; // State D
            3'b100: next_state = (w) ? 3'b011 : 3'b100; // State E
            3'b101: next_state = (w) ? 3'b011 : 3'b010; // State F
            default: next_state = 3'b000; // Illegal states
        endcase
    end

    // Synchronous reset and state update
    always @(posedge clk) begin
        if (reset) begin
            y <= 3'b000; // Reset to State A
        end else begin
            y <= next_state; // Update state
        end
    end

    // Output logic
    assign Y1 = y[1];

endmodule