module TopModule(
    input logic [3:0] x,
    output logic f
);

    always @(*) begin
        case (x)
            4'b0111: f = 1;
            4'b1011: f = 0;
            4'b1110: f = 1;
            4'b1111: f = 1;
            4'b1100: f = 1;
            4'b1101: f = 1;
            4'b1000: f = 1;
            4'b1010: f = 0;
            default: f = 0; // or 'x' depending on whether you prefer a known state or don't-care
        endcase
    end

endmodule