module TopModule (
    input logic in,
    input logic [1:0] state,
    output logic [1:0] next_state,
    output logic out
);

    always @(*) begin
        // Default output
        out = 1'b0;
        
        // State transition logic
        case (state)
            2'b00: begin // State A
                next_state = (in == 1'b0) ? 2'b00 : 2'b01;
            end
            2'b01: begin // State B
                next_state = (in == 1'b0) ? 2'b10 : 2'b01;
            end
            2'b10: begin // State C
                next_state = (in == 1'b0) ? 2'b00 : 2'b11;
            end
            2'b11: begin // State D
                next_state = (in == 1'b0) ? 2'b10 : 2'b01;
                out = 1'b1;
            end
            default: begin
                next_state = 2'b00;
            end
        endcase
    end

endmodule