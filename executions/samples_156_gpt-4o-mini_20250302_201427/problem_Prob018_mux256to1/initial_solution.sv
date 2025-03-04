module TopModule (
    input logic [255:0] in,
    input logic [7:0] sel,
    output logic out
);
    assign out = (sel < 8'd256) ? in[sel] : 1'b0; // Default to 0 if sel is out-of-range
endmodule