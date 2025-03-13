module TopModule (
    input logic a,     // Input signal a (1-bit)
    input logic b,     // Input signal b (1-bit)
    input logic sel,   // Select signal (1-bit)
    output logic out   // Output signal out (1-bit)
);

always @(*) begin
    if (sel == 1'b0) begin
        out = a;  // Select input a
    end else begin
        out = b;  // Select input b
    end
end

endmodule