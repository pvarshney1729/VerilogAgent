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
            6'b000001: next_state = (w) ? 6'b000010 : 6'b000001; // A
            6'b000010: next_state = (w) ? 6'b000100 : 6'b001000; // B
            6'b000100: next_state = (w) ? 6'b010000 : 6'b001000; // C
            6'b001000: next_state = (w) ? 6'b100000 : 6'b000001; // D
            6'b010000: next_state = (w) ? 6'b010000 : 6'b001000; // E
            6'b100000: next_state = (w) ? 6'b000100 : 6'b001000; // F
            default:   next_state = 6'b000001; // Default to A
        endcase
    end

    // Output logic
    assign Y1 = y[1];
    assign Y3 = y[3];

endmodule