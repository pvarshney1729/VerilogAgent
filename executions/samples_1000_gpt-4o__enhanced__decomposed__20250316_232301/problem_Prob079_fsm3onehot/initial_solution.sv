module TopModule(
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

always @(*) begin
    // Default assignments
    next_state = 4'b0000;
    out = 1'b0;

    case (state)
        4'b0001: begin // State A
            if (in == 1'b0)
                next_state = 4'b0001; // Stay in A
            else
                next_state = 4'b0010; // Transition to B
            out = 1'b0;
        end
        4'b0010: begin // State B
            if (in == 1'b0)
                next_state = 4'b0100; // Transition to C
            else
                next_state = 4'b0010; // Stay in B
            out = 1'b0;
        end
        4'b0100: begin // State C
            if (in == 1'b0)
                next_state = 4'b0001; // Transition to A
            else
                next_state = 4'b1000; // Transition to D
            out = 1'b0;
        end
        4'b1000: begin // State D
            if (in == 1'b0)
                next_state = 4'b0100; // Transition to C
            else
                next_state = 4'b0010; // Transition to B
            out = 1'b1;
        end
        default: begin
            next_state = 4'b0001; // Default to state A
            out = 1'b0;
        end
    endcase
end

endmodule