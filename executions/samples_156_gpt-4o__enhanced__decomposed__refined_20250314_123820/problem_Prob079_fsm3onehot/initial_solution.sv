[BEGIN]
module TopModule (
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    always @(*) begin
        case (state)
            4'b0001: next_state = in ? 4'b0010 : 4'b0001; // State A
            4'b0010: next_state = in ? 4'b0010 : 4'b0100; // State B
            4'b0100: next_state = in ? 4'b1000 : 4'b0001; // State C
            4'b1000: next_state = in ? 4'b0010 : 4'b0100; // State D
            default: next_state = 4'b0000; // Undefined state fallback
        endcase
    end

    always @(*) begin
        out = (state == 4'b1000) ? 1'b1 : 1'b0; // Output is 1 only in State D
    end

endmodule
[DONE]