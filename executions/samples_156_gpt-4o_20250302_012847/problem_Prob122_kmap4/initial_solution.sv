module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic y
);

    always @(*) begin
        // Implementing the logic derived from the Karnaugh map
        // Assuming the Karnaugh map results in the following simplified expression:
        // y = (a & b) | (~c & d) | (b & ~d)
        y = (a & b) | (~c & d) | (b & ~d);
    end

endmodule