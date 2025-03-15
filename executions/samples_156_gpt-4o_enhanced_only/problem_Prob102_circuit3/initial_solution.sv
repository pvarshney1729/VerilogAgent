module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

    // Combinational logic for output q
    always @(*) begin
        q = (b & d) | (a & d) | (a & c);
    end

endmodule