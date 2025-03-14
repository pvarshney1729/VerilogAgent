module TopModule (
    input logic [2:0] y,
    input logic w,
    output logic Y1
);

    always @(*) begin
        case (y)
            3'b000: Y1 = (w == 1'b0) ? 1'b0 : 1'b0; // State A
            3'b001: Y1 = (w == 1'b0) ? 1'b0 : 1'b1; // State B
            3'b010: Y1 = (w == 1'b0) ? 1'b1 : 1'b1; // State C
            3'b011: Y1 = (w == 1'b0) ? 1'b1 : 1'b0; // State D
            3'b100: Y1 = 1'b1;                       // State E
            3'b101: Y1 = (w == 1'b0) ? 1'b0 : 1'b1; // State F
            default: Y1 = 1'b0;                      // Default case
        endcase
    end

endmodule