[BEGIN]
module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic reset_n,
    output logic Y1
);

logic [2:0] next_state;

always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        next_state <= 3'b000; // Initialize to state A
    end else begin
        next_state <= (y == 3'b000) ? ((w == 1'b0) ? 3'b001 : 3'b000) :  // State A
                      (y == 3'b001) ? ((w == 1'b0) ? 3'b010 : 3'b011) :  // State B
                      (y == 3'b010) ? ((w == 1'b0) ? 3'b100 : 3'b011) :  // State C
                      (y == 3'b011) ? ((w == 1'b0) ? 3'b101 : 3'b000) :  // State D
                      (y == 3'b100) ? ((w == 1'b0) ? 3'b100 : 3'b011) :  // State E
                      (y == 3'b101) ? ((w == 1'b0) ? 3'b010 : 3'b011) :  // State F
                      3'b000; // Default case
    end
end

assign Y1 = next_state[1];

endmodule
[DONE]