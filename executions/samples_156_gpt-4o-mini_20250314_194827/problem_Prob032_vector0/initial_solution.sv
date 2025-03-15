module TopModule (
    input logic [3:0] in_vector,
    output logic [3:0] out_vector,
    output logic bit0,
    output logic bit1,
    output logic bit2,
    output logic bit3
);

assign out_vector = in_vector;
assign bit0 = in_vector[0];
assign bit1 = in_vector[1];
assign bit2 = in_vector[2];
assign bit3 = in_vector[3];

endmodule