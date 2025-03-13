[BEGIN]
module TopModule (
    input logic in,                   // Single-bit input signal
    input logic [1:0] state,          // 2-bit current state input
    output logic [1:0] next_state,     // 2-bit next state output
    output logic out                   // Single-bit output signal
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = (in == 1'b0) ? 2'b00 : 2'b01; // A -> A or B
            out = 1'b0;
        end
        2'b01: begin // State B
            next_state = (in == 1'b0) ? 2'b10 : 2'b01; // B -> C or B
            out = 1'b0;
        end
        2'b10: begin // State C
            next_state = (in == 1'b0) ? 2'b00 : 2'b11; // C -> A or D
            out = 1'b0;
        end
        2'b11: begin // State D
            next_state = (in == 1'b0) ? 2'b10 : 2'b01; // D -> C or B
            out = 1'b1;
        end
        default: begin // Undefined state handling
            next_state = 2'b00; // Default to state A
            out = 1'b0;
        end
    endcase
end

endmodule
[DONE]