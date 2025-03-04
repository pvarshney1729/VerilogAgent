module TopModule(
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    always @(*) begin
        // Default assignments
        next_state = 4'b0000;
        out = 0;

        case (state)
            4'b0001: begin // State A
                if (in == 0) begin
                    next_state = 4'b0001; // Stay in State A
                end else begin
                    next_state = 4'b0010; // Transition to State B
                end
                out = 0;
            end
            4'b0010: begin // State B
                if (in == 0) begin
                    next_state = 4'b0100; // Transition to State C
                end else begin
                    next_state = 4'b0010; // Stay in State B
                end
                out = 0;
            end
            4'b0100: begin // State C
                if (in == 0) begin
                    next_state = 4'b0001; // Transition to State A
                end else begin
                    next_state = 4'b1000; // Transition to State D
                end
                out = 0;
            end
            4'b1000: begin // State D
                if (in == 0) begin
                    next_state = 4'b0100; // Transition to State C
                end else begin
                    next_state = 4'b0010; // Transition to State B
                end
                out = 1;
            end
            default: begin
                next_state = 4'b0001; // Default to State A for invalid states
                out = 0;
            end
        endcase
    end

endmodule