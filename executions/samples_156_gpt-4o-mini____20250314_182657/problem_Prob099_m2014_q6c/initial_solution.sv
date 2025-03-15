module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    logic [5:0] next_state;

    // Next-state logic for Y2 and Y4
    always @(*) begin
        case (y)
            6'b000001: next_state = (w) ? 6'b000001 : 6'b000010; // State A
            6'b000010: next_state = (w) ? 6'b001000 : 6'b000100; // State B
            6'b000100: next_state = (w) ? 6'b001000 : 6'b010000; // State C
            6'b001000: next_state = (w) ? 6'b000001 : 6'b100000; // State D
            6'b010000: next_state = (w) ? 6'b001000 : 6'b010000; // State E
            6'b100000: next_state = (w) ? 6'b001000 : 6'b000100; // State F
            default: next_state = 6'b000001; // Reset to State A
        endcase
    end

    // Flip-flops for state register
    always @(*) begin
        if (y == 6'b000001) begin
            Y1 = 1'b0; // State A
            Y3 = 1'b0; // State A
        end else if (y == 6'b000010) begin
            Y1 = 1'b0; // State B
            Y3 = 1'b0; // State B
        end else if (y == 6'b000100) begin
            Y1 = 1'b0; // State C
            Y3 = 1'b1; // State C
        end else if (y == 6'b001000) begin
            Y1 = 1'b0; // State D
            Y3 = 1'b1; // State D
        end else if (y == 6'b010000) begin
            Y1 = 1'b1; // State E
            Y3 = 1'b0; // State E
        end else if (y == 6'b100000) begin
            Y1 = 1'b1; // State F
            Y3 = 1'b1; // State F
        end else begin
            Y1 = 1'b0; // Default
            Y3 = 1'b0; // Default
        end
    end

endmodule