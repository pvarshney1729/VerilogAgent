module TopModule (
    input  logic [255:0] in,  // 256-bit wide input vector
    input  logic [7:0]   sel, // 8-bit wide select line
    output logic         out   // 1-bit output
);
    assign out = (sel <= 8'd255) ? in[sel] : 1'bz; // Use high impedance for out if sel > 255
endmodule