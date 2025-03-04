module TopModule (
    input logic [3:0] in,
    output logic [1:0] pos
);

    always @(*) begin
        case (in)
            4'b1000: pos = 2'b11; // MSB high
            4'b0100: pos = 2'b10; // Second bit high
            4'b0010: pos = 2'b01; // Third bit high
            4'b0001: pos = 2'b00; // LSB high
            default: pos = 2'b00;  // All bits low
        endcase
    end

endmodule