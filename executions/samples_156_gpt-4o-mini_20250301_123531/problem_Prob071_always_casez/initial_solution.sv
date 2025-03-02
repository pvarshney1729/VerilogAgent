module TopModule (
    input logic [7:0] data_in,
    output logic [2:0] position
);

always @(*) begin
    case (data_in)
        8'b00000001: position = 3'd0;
        8'b00000010: position = 3'd1;
        8'b00000100: position = 3'd2;
        8'b00001000: position = 3'd3;
        8'b00010000: position = 3'd4;
        8'b00100000: position = 3'd5;
        8'b01000000: position = 3'd6;
        8'b10000000: position = 3'd7;
        default:     position = 3'd0; // All zeros case
    endcase
end

endmodule