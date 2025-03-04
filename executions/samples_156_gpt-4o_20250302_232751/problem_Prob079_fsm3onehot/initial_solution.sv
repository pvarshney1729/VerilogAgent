module TopModule (
    input logic in,               // 1-bit input, unsigned
    input logic [3:0] state,      // 4-bit input, unsigned, one-hot encoded current state
    output logic [3:0] next_state,// 4-bit output, unsigned, one-hot encoded next state
    output logic out              // 1-bit output, unsigned
);

    always @(*) begin
        // Default assignments
        next_state = 4'b0000;
        out = 1'b0;

        // State transition logic
        case (state)
            4'b0001: begin // State A
                if (in == 1'b0) begin
                    next_state = 4'b0001; // Stay in A
                end else begin
                    next_state = 4'b0010; // Move to B
                end
                out = 1'b0;
            end
            4'b0010: begin // State B
                if (in == 1'b0) begin
                    next_state = 4'b0100; // Move to C
                end else begin
                    next_state = 4'b0010; // Stay in B
                end
                out = 1'b0;
            end
            4'b0100: begin // State C
                if (in == 1'b0) begin
                    next_state = 4'b0001; // Move to A
                end else begin
                    next_state = 4'b1000; // Move to D
                end
                out = 1'b0;
            end
            4'b1000: begin // State D
                if (in == 1'b0) begin
                    next_state = 4'b0100; // Move to C
                end else begin
                    next_state = 4'b0010; // Move to B
                end
                out = 1'b1;
            end
            default: begin
                // Undefined state, default to State A
                next_state = 4'b0001;
                out = 1'b0;
            end
        endcase
    end

endmodule