module TopModule(
    input logic in,
    input logic [1:0] state,
    output logic [1:0] next_state,
    output logic out
);

    always @(*) begin
        // Default assignments
        next_state = 2'b00;  // Default to state A
        out = 1'b0;          // Default output is 0
        
        // State transition and output logic
        case (state)
            2'b00: begin // State A
                next_state = (in == 1'b0) ? 2'b00 : 2'b01; // A -> A or A -> B
                out = 1'b0;
            end
            2'b01: begin // State B
                next_state = (in == 1'b0) ? 2'b10 : 2'b01; // B -> C or B -> B
                out = 1'b0;
            end
            2'b10: begin // State C
                next_state = (in == 1'b0) ? 2'b00 : 2'b11; // C -> A or C -> D
                out = 1'b0;
            end
            2'b11: begin // State D
                next_state = (in == 1'b0) ? 2'b10 : 2'b01; // D -> C or D -> B
                out = 1'b1;
            end
            default: begin
                next_state = 2'b00; // Default to state A if an invalid state is encountered
                out = 1'b0;
            end
        endcase
    end

endmodule