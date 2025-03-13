[BEGIN]
module TopModule (
    input logic in,                // Input signal (1 bit)
    input logic [1:0] state,      // Current state (2 bits, unsigned)
    output logic [1:0] next_state, // Next state (2 bits, unsigned)
    output logic out               // Output signal (1 bit)
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = (in) ? 2'b01 : 2'b00; // A on in=0, B on in=1
            out = 1'b0;
        end
        2'b01: begin // State B
            next_state = (in) ? 2'b01 : 2'b10; // B on in=1, C on in=0
            out = 1'b0;
        end
        2'b10: begin // State C
            next_state = (in) ? 2'b11 : 2'b00; // D on in=1, A on in=0
            out = 1'b0;
        end
        2'b11: begin // State D
            next_state = (in) ? 2'b01 : 2'b10; // B on in=1, C on in=0
            out = 1'b1;
        end
        default: begin // Undefined state handling
            next_state = 2'b00; // Reset to state A
            out = 1'b0;
        end
    endcase
end

endmodule
[DONE]