module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

logic state_reg, next_state;

always @(posedge clk) begin
    state_reg <= next_state;
end

always @(*) begin
    case ({state_reg, a, b})
        3'b000: next_state = 0;
        3'b001: next_state = 0;
        3'b010: next_state = 0;
        3'b011: next_state = 0;
        3'b100: next_state = 1;
        3'b101: next_state = 0;
        3'b110: next_state = 0;
        3'b111: next_state = 1;
        default: next_state = 0;
    endcase
end

assign state = state_reg;
assign q = (state_reg == 1) ? 1 : 0;

endmodule