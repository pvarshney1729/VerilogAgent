module TopModule (
    input  logic in,
    input  logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    always @(*) begin
        // Default assignments
        next_state = 4'b0000;
        out = 1'b0;

        case (state)
            4'b0001: begin // State A
                if (in) next_state = 4'b0010; // Next state B
                else next_state = 4'b0001; // Stay in A
            end
            4'b0010: begin // State B
                if (in) next_state = 4'b0010; // Stay in B
                else next_state = 4'b0100; // Next state C
            end
            4'b0100: begin // State C
                if (in) next_state = 4'b1000; // Next state D
                else next_state = 4'b0001; // Next state A
            end
            4'b1000: begin // State D
                if (in) next_state = 4'b0010; // Next state B
                else next_state = 4'b0100; // Next state C
                out = 1'b1; // Output is 1
            end
        endcase
    end

endmodule