module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3,
    input logic reset,
    input logic clk
);

    always @(posedge clk) begin
        if (reset) begin
            y <= 6'b000001; // Reset to state A
        end else begin
            case (y)
                6'b000001: y <= (w) ? 6'b000010 : 6'b000001; // State A
                6'b000010: y <= (w) ? 6'b000100 : 6'b001000; // State B
                6'b000100: y <= (w) ? 6'b010000 : 6'b001000; // State C
                6'b001000: y <= (w) ? 6'b100000 : 6'b000001; // State D
                6'b010000: y <= (w) ? 6'b010000 : 6'b001000; // State E
                6'b100000: y <= (w) ? 6'b000100 : 6'b001000; // State F
                default:   y <= 6'b000001; // Undefined state, go to A
            endcase
        end
    end

    assign Y1 = y[1]; // Output for state B
    assign Y3 = y[3]; // Output for state D

endmodule