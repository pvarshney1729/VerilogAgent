module TopModule (
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    always @(*) begin
        case (state)
            4'b0001: next_state = (in == 0) ? 4'b0001 : 4'b0010;
            4'b0010: next_state = (in == 0) ? 4'b0100 : 4'b0010;
            4'b0100: next_state = (in == 0) ? 4'b0001 : 4'b1000;
            4'b1000: next_state = (in == 0) ? 4'b0100 : 4'b0010;
            default: next_state = 4'b0000; // Fault condition
        endcase
    end

    assign out = (state == 4'b1000) ? 1'b1 : 1'b0;

endmodule