module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic reset_n,
    output logic Y1
);

    logic [2:0] next_state;

    // Output logic
    assign Y1 = y[1];

    // State transition logic
    always @(*) begin
        case (y)
            3'b000: next_state = (w == 1'b0) ? 3'b001 : 3'b000; // State A
            3'b001: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // State B
            3'b010: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // State C
            3'b011: next_state = (w == 1'b0) ? 3'b101 : 3'b000; // State D
            3'b100: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // State E
            3'b101: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // State F
            default: next_state = 3'b000; // Handle unused states
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (~reset_n) begin
            y <= 3'b000; // Reset to State A
        end else begin
            y <= next_state; // Update state
        end
    end

endmodule