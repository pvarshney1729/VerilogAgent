module TopModule(
    input logic [2:0] y,
    input logic w,
    output logic Y1
);
    logic [2:0] next_state;

    always @(*) begin
        case (y)
            3'b000: next_state = (w == 1'b0) ? 3'b001 : 3'b000; // A
            3'b001: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // B
            3'b010: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // C
            3'b011: next_state = (w == 1'b0) ? 3'b101 : 3'b000; // D
            3'b100: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // E
            3'b101: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // F
            default: next_state = 3'b000; // Default to A
        endcase
    end

    assign Y1 = y[1];

endmodule