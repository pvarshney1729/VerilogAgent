module TopModule (
    input wire input_wire,  // 1-bit input
    output wire output_wire // 1-bit output
);
    // Combinational pass-through
    assign output_wire = input_wire;
endmodule