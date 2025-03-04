module TopModule(
    input logic in,
    input logic [1:0] state,
    input logic rst,
    output logic [1:0] next_state,
    output logic out
);

    always @(*) begin
        // Default output values
        next_state = 2'b00; // Default to state A
        out = 1'b0;         // Default output

        // State transition logic
        case (state)
            2'b00: begin // State A
                if (in == 1'b0) begin
                    next_state = 2'b00; // Stay in A
                end else begin
                    next_state = 2'b01; // Move to B
                end
                out = 1'b0;
            end
            2'b01: begin // State B
                if (in == 1'b0) begin
                    next_state = 2'b10; // Move to C
                end else begin
                    next_state = 2'b01; // Stay in B
                end
                out = 1'b0;
            end
            2'b10: begin // State C
                if (in == 1'b0) begin
                    next_state = 2'b00; // Move to A
                end else begin
                    next_state = 2'b11; // Move to D
                end
                out = 1'b0;
            end
            2'b11: begin // State D
                if (in == 1'b0) begin
                    next_state = 2'b10; // Move to C
                end else begin
                    next_state = 2'b01; // Move to B
                end
                out = 1'b1;
            end
            default: begin
                next_state = 2'b00; // Default to state A
                out = 1'b0;
            end
        endcase
    end

endmodule