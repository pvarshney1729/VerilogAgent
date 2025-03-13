[BEGIN]
module TopModule (
    input logic in,              // 1-bit input signal
    input logic [3:0] state,     // 4-bit input representing the current state (one-hot encoded)
    output logic [3:0] next_state,// 4-bit output representing the next state (one-hot encoded)
    output logic out             // 1-bit output signal
);

always @(*) begin
    case (state)
        4'b0001: next_state = (in) ? 4'b0010 : 4'b0001; // State A
        4'b0010: next_state = (in) ? 4'b0010 : 4'b0100; // State B
        4'b0100: next_state = (in) ? 4'b1000 : 4'b0001; // State C
        4'b1000: next_state = (in) ? 4'b0010 : 4'b0100; // State D
        default: next_state = 4'b0001; // Default to State A
    endcase
end

always @(*) begin
    out = (state == 4'b1000 && in) ? 1'b1 : 1'b0; // Output logic
end

endmodule
[DONE]