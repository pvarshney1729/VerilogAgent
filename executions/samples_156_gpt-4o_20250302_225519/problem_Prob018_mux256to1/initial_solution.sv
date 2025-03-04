module TopModule (
    input logic [255:0] input_vector,  // 256-bit wide input vector
    input logic [7:0] sel,             // 8-bit wide selection input
    output logic out                   // 1-bit output
);

    // Combinational Logic Description
    // The module implements a combinational 1-bit wide, 256-to-1 multiplexer.
    // The input_vector[0] is the least significant bit of the input vector.
    // sel=0 selects input_vector[0], sel=1 selects input_vector[1], ..., sel=255 selects input_vector[255].

    // Handle boundary condition: If sel > 255, default to selecting input_vector[0] (wrap around).
    assign out = (sel < 8'd256) ? input_vector[sel] : input_vector[0];

endmodule