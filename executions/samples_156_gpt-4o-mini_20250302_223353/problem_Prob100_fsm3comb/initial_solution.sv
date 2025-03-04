module TopModule (
    input logic in,
    input logic [1:0] state,
    output logic [1:0] next_state,
    output logic out
);

    always @(*) begin
        case (state)
            2'b00: begin // State A
                next_state = (in) ? 2'b01 : 2'b00; // A -> B or stay A
                out = 1'b0; // Output for A
            end
            2'b01: begin // State B
                next_state = (in) ? 2'b01 : 2'b10; // B -> B or B -> C
                out = 1'b0; // Output for B
            end
            2'b10: begin // State C
                next_state = (in) ? 2'b11 : 2'b00; // C -> D or C -> A
                out = 1'b0; // Output for C
            end
            2'b11: begin // State D
                next_state = (in) ? 2'b01 : 2'b10; // D -> B or D -> C
                out = 1'b1; // Output for D
            end
            default: begin
                next_state = 2'b00; // Default to State A
                out = 1'b0; // Default output
            end
        endcase
    end

endmodule