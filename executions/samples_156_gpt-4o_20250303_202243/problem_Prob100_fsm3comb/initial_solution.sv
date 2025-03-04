module TopModule (
    input wire in,                   // 1-bit input signal
    input wire [1:0] current_state,  // 2-bit input representing the current state
    output reg [1:0] next_state,     // 2-bit output representing the next state
    output reg out                   // 1-bit output signal
);

    always @(*) begin
        case (current_state)
            2'b00: begin // State A
                next_state = (in == 1'b0) ? 2'b00 : 2'b01;
                out = 1'b0;
            end
            2'b01: begin // State B
                next_state = (in == 1'b0) ? 2'b10 : 2'b01;
                out = 1'b0;
            end
            2'b10: begin // State C
                next_state = (in == 1'b0) ? 2'b00 : 2'b11;
                out = 1'b0;
            end
            2'b11: begin // State D
                next_state = (in == 1'b0) ? 2'b10 : 2'b01;
                out = 1'b1;
            end
            default: begin
                next_state = 2'b00; // Default to State A
                out = 1'b0;
            end
        endcase
    end

endmodule