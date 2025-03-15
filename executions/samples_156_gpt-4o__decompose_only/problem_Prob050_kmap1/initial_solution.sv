module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    output logic out
);

    // Implement the logic derived from the Karnaugh map
    always @(*) begin
        out = a | b | c;
    end

endmodule