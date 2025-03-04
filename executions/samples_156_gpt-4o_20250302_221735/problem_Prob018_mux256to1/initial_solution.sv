module TopModule (
    input  logic [255:0] data_input,  // 256-bit input vector
    input  logic [7:0]   select,      // 8-bit selector input
    output logic         data_output  // 1-bit output
);
    assign data_output = data_input[select];
endmodule