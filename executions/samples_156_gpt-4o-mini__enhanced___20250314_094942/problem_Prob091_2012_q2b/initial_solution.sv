module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    // State transition logic
    logic [5:0] next_state;

    always @(*) begin
        case (1'b1)
            y[0]: next_state = (w) ? 6'b000010 : 6'b000001; // A
            y[1]: next_state = (w) ? 6'b000100 : 6'b001000; // B
            y[2]: next_state = (w) ? 6'b010000 : 6'b001000; // C
            y[3]: next_state = (w) ? 6'b100000 : 6'b000001; // D
            y[4]: next_state = (w) ? 6'b010000 : 6'b001000; // E
            y[5]: next_state = (w) ? 6'b000100 : 6'b001000; // F
            default: next_state = 6'b000001; // Default to A
        endcase
    end

    // Output logic
    assign Y1 = y[1]; // Output from state B
    assign Y3 = y[3]; // Output from state D

endmodule