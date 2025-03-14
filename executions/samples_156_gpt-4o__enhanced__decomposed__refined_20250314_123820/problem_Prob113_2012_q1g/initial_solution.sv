[BEGIN]
module TopModule (
    input logic [3:0] x,
    output logic f
);
    always @(*) begin
        case (x[3:2])
            2'b00: f = (x[1:0] == 2'b00) || (x[1:0] == 2'b10);
            2'b01: f = 1'b0;
            2'b11: f = (x[1:0] == 2'b00) || (x[1:0] == 2'b01) || (x[1:0] == 2'b11);
            2'b10: f = (x[1:0] == 2'b00) || (x[1:0] == 2'b01) || (x[1:0] == 2'b10);
            default: f = 1'b0;
        endcase
    end
endmodule
[DONE]