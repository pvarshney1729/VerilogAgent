module TopModule(
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output logic [3:0] q
);

always @(*) begin
    case (c)
        4'd0: q = b; // When c is 0
        4'd1: q = e; // When c is 1
        4'd2: q = a; // When c is 2
        4'd3: q = d; // When c is 3
        default: q = 4'hf; // When c is 4 or above
    endcase
end

endmodule