module TopModule (
    input logic [3:0] x,
    output logic f
);

    always @(*) begin
        case (x)
            4'b0001: f = 1'b0;
            4'b0100: f = 1'b0;
            4'b0110: f = 1'b1;
            4'b0111: f = 1'b0;
            4'b1000: f = 1'b1;
            4'b1001: f = 1'b1;
            4'b1100: f = 1'b1;
            4'b1101: f = 1'b1;
            4'b1110: f = 1'b0;
            default: f = 1'b0; // Assign default value for don't-care conditions
        endcase
    end

endmodule