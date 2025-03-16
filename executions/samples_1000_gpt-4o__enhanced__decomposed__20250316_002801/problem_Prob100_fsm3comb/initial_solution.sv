module TopModule(
    input logic in,
    input logic [1:0] state,
    output logic [1:0] next_state,
    output logic out
);

    // Combinational logic for state transition
    always @(*) begin
        case (state)
            2'b00: next_state = (in == 1'b0) ? 2'b00 : 2'b01; // State A
            2'b01: next_state = (in == 1'b0) ? 2'b10 : 2'b01; // State B
            2'b10: next_state = (in == 1'b0) ? 2'b00 : 2'b11; // State C
            2'b11: next_state = (in == 1'b0) ? 2'b10 : 2'b01; // State D
            default: next_state = 2'b00; // Default to State A
        endcase
    end

    // Combinational logic for output
    assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Output logic based on state

endmodule