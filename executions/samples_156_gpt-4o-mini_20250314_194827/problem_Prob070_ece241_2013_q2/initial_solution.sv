module combinational_logic (
    input logic a,
    input logic b,
    input logic c,
    output logic out_sop,
    output logic out_pos
);

    // Combinational logic for out_sop
    always @(*) begin
        out_sop = (a & b) | (b & c) | (c & a); // Example SOP logic
    end

    // Combinational logic for out_pos
    always @(*) begin
        out_pos = a | b | c; // Example POS logic
    end

endmodule