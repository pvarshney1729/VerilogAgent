module TopModule(
    input logic in,
    input logic [1:0] state,
    output logic [1:0] next_state,
    output logic out
);

    always @(*) begin
        case (state)
            2'b00: begin // State A
                if (in == 1'b0) begin
                    next_state = 2'b00; // Stay in A
                    out = 1'b0;
                end else begin
                    next_state = 2'b01; // Transition to B
                    out = 1'b0;
                end
            end
            2'b01: begin // State B
                if (in == 1'b0) begin
                    next_state = 2'b10; // Transition to C
                    out = 1'b0;
                end else begin
                    next_state = 2'b01; // Stay in B
                    out = 1'b0;
                end
            end
            2'b10: begin // State C
                if (in == 1'b0) begin
                    next_state = 2'b00; // Transition to A
                    out = 1'b0;
                end else begin
                    next_state = 2'b11; // Transition to D
                    out = 1'b0;
                end
            end
            2'b11: begin // State D
                if (in == 1'b0) begin
                    next_state = 2'b10; // Transition to C
                    out = 1'b1;
                end else begin
                    next_state = 2'b01; // Transition to B
                    out = 1'b1;
                end
            end
            default: begin
                next_state = 2'b00; // Default to state A
                out = 1'b0;
            end
        endcase
    end

endmodule