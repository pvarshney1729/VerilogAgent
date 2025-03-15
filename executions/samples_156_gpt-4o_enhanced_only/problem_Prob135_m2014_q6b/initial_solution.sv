module TopModule(
    input logic [2:0] y,  // 3-bit input representing the current state
    input logic w,        // 1-bit input for state transition control
    output logic Y1       // 1-bit output representing y[1]
);

    // Next-state logic for y[1]
    always @(*) begin
        case (y)
            3'b000: Y1 = 0; // State A transitions
            3'b001: Y1 = w; // State B transitions
            3'b010: Y1 = 1; // State C transitions
            3'b011: Y1 = 0; // State D transitions
            3'b100: Y1 = 1; // State E transitions
            3'b101: Y1 = 1; // State F transitions
            default: Y1 = 0; // Default case to handle undefined states
        endcase
    end

endmodule