module TopModule(
    input [3:0] x,
    output logic f
);

    always @(*) begin
        case (x)
            4'b0001: f = 0;
            4'b0100: f = 0;
            4'b0110: f = 0;
            4'b1000: f = 1;
            4'b1001: f = 1;
            4'b1010: f = 1;
            4'b1100: f = 0;
            4'b0111: f = 1;
            4'b0011: f = 1;
            default: f = 0; // Handling don't-care conditions
        endcase
    end

endmodule