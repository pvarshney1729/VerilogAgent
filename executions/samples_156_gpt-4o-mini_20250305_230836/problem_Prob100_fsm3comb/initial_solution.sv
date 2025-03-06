module TopModule (
    input logic in,
    input logic [1:0] state,
    output logic [1:0] next_state,
    output logic out
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = (in) ? 2'b01 : 2'b00; // A -> B or stay in A
            out = 1'b0;
        end
        2'b01: begin // State B
            next_state = (in) ? 2'b01 : 2'b10; // B -> B or B -> C
            out = 1'b0;
        end
        2'b10: begin // State C
            next_state = (in) ? 2'b11 : 2'b00; // C -> D or C -> A
            out = 1'b0;
        end
        2'b11: begin // State D
            next_state = (in) ? 2'b01 : 2'b10; // D -> B or D -> C
            out = 1'b1;
        end
        default: begin // Undefined state handling
            next_state = 2'b00; // Default to state A
            out = 1'b0;
        end
    endcase
end

endmodule