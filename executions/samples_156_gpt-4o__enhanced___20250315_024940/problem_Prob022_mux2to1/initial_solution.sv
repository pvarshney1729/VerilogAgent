module TopModule (
    input logic a,  // 1-bit input
    input logic b,  // 1-bit input
    input logic sel, // 1-bit input
    output logic out // 1-bit output
);

    // Combinational logic to select output based on sel
    always @(*) begin
        if (sel == 1'b0) begin
            out = a; // When sel is 0, output a
        end else begin
            out = b; // When sel is 1, output b
        end
    end

endmodule