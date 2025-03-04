module TopModule (
    input logic [255:0] in,   // 256-bit wide input vector, unsigned
    input logic [7:0] sel,    // 8-bit wide selection signal, unsigned
    output logic out          // 1-bit wide output
);

    // Combinational logic to select the bit from 'in' based on 'sel'
    assign out = in[sel];

endmodule