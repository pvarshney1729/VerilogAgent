module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    output logic out
);

always @(*) begin
    case ({b, c})
        2'b00: out = a;
        2'b01: out = 1'b1;
        2'b10: out = 1'b1;
        2'b11: out = 1'b1;
        default: out = 1'b0; // Default case to handle any unexpected inputs
    endcase
end

endmodule