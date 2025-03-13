module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    logic [5:0] next_state;

    // Next-state logic based on the state machine description
    always @(*) begin
        case (1'b1) // one-hot encoding
            y[0]: next_state = (w) ? y[0] : 6'b000010; // State A
            y[1]: next_state = (w) ? 6'b000001 : 6'b000100; // State B
            y[2]: next_state = (w) ? 6'b000100 : 6'b001000; // State C
            y[3]: next_state = (w) ? 6'b000001 : 6'b001000; // State D
            y[4]: next_state = (w) ? 6'b001000 : 6'b001000; // State E
            y[5]: next_state = (w) ? 6'b000100 : 6'b000100; // State F
            default: next_state = 6'b000001; // Reset to State A
        endcase
    end

    // Output logic
    assign Y1 = y[1]; // Corresponds to state B
    assign Y3 = y[3]; // Corresponds to state D

endmodule