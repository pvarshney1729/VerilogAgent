module TopModule (
    input logic in,              // 1-bit input signal, unsigned
    input logic [3:0] state,     // 4-bit input signal representing current state, one-hot encoded
    output logic [3:0] next_state, // 4-bit output signal representing next state, one-hot encoded
    output logic out             // 1-bit output signal, unsigned
);

    always @(*) begin
        // Default values for next_state and out
        next_state = 4'b0001; // Default to state A
        out = 1'b0;           // Default output

        case (state)
            4'b0001: begin // State A
                next_state = (in == 1'b0) ? 4'b0001 : 4'b0010; // Stay in A or move to B
                out = 1'b0;
            end
            4'b0010: begin // State B
                next_state = (in == 1'b0) ? 4'b0100 : 4'b0010; // Move to C or stay in B
                out = 1'b0;
            end
            4'b0100: begin // State C
                next_state = (in == 1'b0) ? 4'b0001 : 4'b1000; // Move to A or D
                out = 1'b0;
            end
            4'b1000: begin // State D
                next_state = (in == 1'b0) ? 4'b0100 : 4'b0010; // Move to C or B
                out = 1'b1;
            end
            default: begin // Invalid state
                next_state = 4'b0001; // Default to state A
                out = 1'b0;
            end
        endcase
    end

endmodule