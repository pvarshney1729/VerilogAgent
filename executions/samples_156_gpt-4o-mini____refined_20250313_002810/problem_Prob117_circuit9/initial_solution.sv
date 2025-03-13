[BEGIN]
module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);
    logic [2:0] state;
    logic [2:0] next_state;

    always @(*) begin
        case (state)
            3'b000: next_state = (a) ? 3'b001 : 3'b000;
            3'b001: next_state = (a) ? 3'b010 : 3'b001;
            3'b010: next_state = (a) ? 3'b011 : 3'b010;
            3'b011: next_state = (a) ? 3'b100 : 3'b011;
            3'b100: next_state = (a) ? 3'b101 : 3'b100;
            3'b101: next_state = (!a) ? 3'b110 : 3'b101;
            3'b110: next_state = (!a) ? 3'b000 : 3'b110;
            default: next_state = 3'b000;
        endcase
    end

    always @(posedge clk) begin
        state <= next_state;
    end

    assign q = state;

endmodule
[DONE]