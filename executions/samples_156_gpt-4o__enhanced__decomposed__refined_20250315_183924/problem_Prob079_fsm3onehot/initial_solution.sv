module TopModule(
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    // Next State Logic
    always @(*) begin
        case (state)
            4'b0001: next_state = (in == 0) ? 4'b0001 : 4'b0010; // A -> A or B
            4'b0010: next_state = (in == 0) ? 4'b0100 : 4'b0010; // B -> C or B
            4'b0100: next_state = (in == 0) ? 4'b0001 : 4'b1000; // C -> A or D
            4'b1000: next_state = (in == 0) ? 4'b0100 : 4'b0010; // D -> C or B
            default: next_state = 4'b0000; // Invalid state
        endcase
    end

    // Output Logic
    assign out = (state == 4'b1000) ? 1'b1 : 1'b0;

endmodule