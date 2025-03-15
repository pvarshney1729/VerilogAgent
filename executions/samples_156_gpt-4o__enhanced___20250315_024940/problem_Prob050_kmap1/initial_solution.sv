module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    output logic out
);

    // Combinational logic derived from the Karnaugh map
    always @(*) begin
        out = (b & c) | (a & (b | c)) | (b & ~a);
    end

endmodule