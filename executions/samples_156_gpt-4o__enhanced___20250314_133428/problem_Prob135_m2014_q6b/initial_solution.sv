module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic rst,
    output logic Y1
);

    logic [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            3'b000: next_state = (w == 1'b0) ? 3'b001 : 3'b000; // A
            3'b001: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // B
            3'b010: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // C
            3'b011: next_state = (w == 1'b0) ? 3'b101 : 3'b000; // D
            3'b100: next_state = (w == 1'b0) ? 3'b100 : 3'b011; // E
            3'b101: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // F
            default: next_state = 3'b000; // Undefined states reset to A
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (rst) begin
            state <= 3'b000; // Reset to state A
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign Y1 = state[1];

endmodule