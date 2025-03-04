module TopModule(
    input logic [3:0] x,
    output logic f
);

    always @(*) begin
        case (x[3:2])
            2'b00: f = (x[1:0] == 2'b01) ? 1'b0 : 1'b1; // Don't-care for 00, 10, 11
            2'b01: f = (x[1:0] == 2'b00 || x[1:0] == 2'b10) ? 1'b0 : 1'b1; // Don't-care for 01, 11
            2'b11: f = (x[1:0] == 2'b00 || x[1:0] == 2'b01) ? 1'b1 : 1'b0; // Don't-care for 10, 11
            2'b10: f = (x[1:0] == 2'b00 || x[1:0] == 2'b01) ? 1'b1 : 1'b0; // Don't-care for 11
            default: f = 1'b0; // Default case for safety
        endcase
    end

endmodule