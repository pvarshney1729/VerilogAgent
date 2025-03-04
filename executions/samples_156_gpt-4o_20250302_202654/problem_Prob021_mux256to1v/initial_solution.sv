module TopModule (
    input logic [1023:0] in,
    input logic [7:0] sel,
    output logic [3:0] out
);
    assign out = (sel <= 255) ? in[sel * 4 +: 4] : 4'b0000;  // Default behavior for out-of-range sel
endmodule