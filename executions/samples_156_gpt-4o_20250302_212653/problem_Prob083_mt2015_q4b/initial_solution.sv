module TopModule (
    input logic x,           // 1-bit input signal, assumed unsigned
    input logic y,           // 1-bit input signal, assumed unsigned
    output logic z           // 1-bit output signal, assumed unsigned
);

always @(*) begin
    if (x == 0 && y == 0)
        z = 1'b1;
    else if (x == 1 && y == 0)
        z = 1'b0;
    else if (x == 0 && y == 1)
        z = 1'b0;
    else if (x == 1 && y == 1)
        z = 1'b1;
end

endmodule