module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic q
);

    // Combinational logic to determine the output q
    always @(*) begin
        q = (b & c) | (b & d) | (a & d);
    end

endmodule