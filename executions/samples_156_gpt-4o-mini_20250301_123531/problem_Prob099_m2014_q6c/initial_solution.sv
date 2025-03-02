module TopModule (
    input logic [5:0] y,
    input logic w,
    input logic clk,
    input logic async_reset,
    output logic Y1,
    output logic Y3
);

logic [5:0] next_state;

always_ff @(posedge clk or posedge async_reset) begin
    if (async_reset) begin
        next_state <= 6'b000001; // State A
    end else begin
        next_state <= next_state; // Default to hold state
    end
end

always_comb begin
    case (y)
        6'b000001: next_state = (w) ? 6'b000001 : 6'b000010; // State A
        6'b000010: next_state = (w) ? 6'b001000 : 6'b000100; // State B
        6'b000100: next_state = (w) ? 6'b001000 : 6'b010000; // State C
        6'b001000: next_state = (w) ? 6'b000001 : 6'b100000; // State D
        6'b010000: next_state = (w) ? 6'b001000 : 6'b010000; // State E
        6'b100000: next_state = (w) ? 6'b001000 : 6'b000100; // State F
        default:   next_state = 6'b000001; // Default to State A
    endcase
end

assign Y1 = next_state[1];
assign Y3 = next_state[3];

endmodule