module TopModule (
    input  logic in,
    input  logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    always @(*) begin
        // Default assignments
        next_state = 4'b0000; // Reset next_state to zero
        out = 1'b0;           // Default output is 0

        case (state)
            4'b0001: begin // State A
                next_state = (in) ? 4'b0010 : 4'b0001; // A -> B if in=1, else stay in A
                out = 1'b0; // Output for state A
            end
            4'b0010: begin // State B
                next_state = (in) ? 4'b0010 : 4'b0100; // B -> B if in=1, else B -> C
                out = 1'b0; // Output for state B
            end
            4'b0100: begin // State C
                next_state = (in) ? 4'b1000 : 4'b0001; // C -> D if in=1, else C -> A
                out = 1'b0; // Output for state C
            end
            4'b1000: begin // State D
                next_state = (in) ? 4'b0010 : 4'b0100; // D -> B if in=1, else D -> C
                out = 1'b1; // Output for state D
            end
            default: begin
                next_state = 4'b0000; // Default state if none match (safety)
                out = 1'b0; // Default output
            end
        endcase
    end

endmodule