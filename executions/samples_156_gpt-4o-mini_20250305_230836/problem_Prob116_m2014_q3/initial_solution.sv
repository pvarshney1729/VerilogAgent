module TopModule(
    input [3:0] x,
    output logic f
);
    always @(*) begin
        case (x[3:0])
            4'b0001: f = 0;
            4'b0100: f = 0;
            4'b0101: f = 0;
            4'b0111: f = 1;
            4'b1000: f = 1;
            4'b1001: f = 1;
            4'b1010: f = 0;
            4'b1100: f = 1;
            4'b1101: f = 1;
            default: f = 1'bx; // don't-care conditions
        endcase
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly