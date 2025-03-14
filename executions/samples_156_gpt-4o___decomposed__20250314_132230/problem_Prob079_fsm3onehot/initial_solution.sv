module TopModule(
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    always @(*) begin
        // Default assignment
        next_state = 4'b0000;
        out = 1'b0;

        case (state)
            4'b0001: begin // State A
                next_state = (in == 1'b0) ? 4'b0001 : 4'b0010;
                out = 1'b0;
            end
            4'b0010: begin // State B
                next_state = (in == 1'b0) ? 4'b0100 : 4'b0010;
                out = 1'b0;
            end
            4'b0100: begin // State C
                next_state = (in == 1'b0) ? 4'b0001 : 4'b1000;
                out = 1'b0;
            end
            4'b1000: begin // State D
                next_state = (in == 1'b0) ? 4'b0100 : 4'b0010;
                out = 1'b1;
            end
            default: begin
                next_state = 4'b0001; // Default to state A
                out = 1'b0;
            end
        endcase
    end

endmodule