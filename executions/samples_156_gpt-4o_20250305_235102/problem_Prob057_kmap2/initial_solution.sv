module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        case ({c, d, a, b})
            4'b0000, 4'b0001, 4'b0010, 4'b0011, // c == 0 && d == 0
            4'b0100, 4'b0101,                  // c == 0 && d == 1
            4'b1110, 4'b1111,                  // c == 1 && d == 1
            4'b1000, 4'b1001:                  // c == 1 && d == 0
                out = 1'b1;
            default:
                out = 1'b0;
        endcase
    end

endmodule