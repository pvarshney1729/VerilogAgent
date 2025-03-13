module TopModule (
    input  logic [5:0] y,
    input  logic w,
    output logic Y1,
    output logic Y3
);

    logic [5:0] next_state;

    // State transition logic
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

    // Flip-flops for state storage
    always @(posedge w) begin
        if (y == 6'b000001) begin
            Y1 <= 1'b0; // State A
            Y3 <= 1'b0; // State A
        end else if (y == 6'b000010) begin
            Y1 <= 1'b1; // State B
            Y3 <= 1'b0; // State B
        end else if (y == 6'b000100) begin
            Y1 <= 1'b0; // State C
            Y3 <= 1'b1; // State C
        end else if (y == 6'b001000) begin
            Y1 <= 1'b0; // State D
            Y3 <= 1'b0; // State D
        end else if (y == 6'b010000) begin
            Y1 <= 1'b0; // State E
            Y3 <= 1'b0; // State E
        end else if (y == 6'b100000) begin
            Y1 <= 1'b0; // State F
            Y3 <= 1'b0; // State F
        end
    end

endmodule