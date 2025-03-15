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

        // State transition logic
        case (state)
            4'b0001: begin // State A
                next_state = in ? 4'b0010 : 4'b0001;
            end
            4'b0010: begin // State B
                next_state = in ? 4'b0010 : 4'b0100;
            end
            4'b0100: begin // State C
                next_state = in ? 4'b1000 : 4'b0001;
            end
            4'b1000: begin // State D
                next_state = in ? 4'b0010 : 4'b0100;
                out = 1'b1; // Output logic for state D
            end
            default: begin
                next_state = 4'b0001; // Default to state A
            end
        endcase
    end

endmodule