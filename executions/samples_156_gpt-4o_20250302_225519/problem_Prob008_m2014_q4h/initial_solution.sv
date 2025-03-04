module TopModule (
    input wire i_data,  // One-bit wide input
    output wire o_data  // One-bit wide output
);

    // Continuous assignment for combinational logic
    assign o_data = i_data;

endmodule