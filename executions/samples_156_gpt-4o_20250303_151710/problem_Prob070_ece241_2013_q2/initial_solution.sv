module TopModule (
    input  logic [3:0] in_bus,
    output logic       out_sop,
    output logic       out_pos
);

    // Sum-of-Products (SOP) implementation
    assign out_sop = (~in_bus[3] & ~in_bus[2] & in_bus[1] & ~in_bus[0]) |
                     (~in_bus[3] & in_bus[2] & in_bus[1] & in_bus[0]) |
                     (in_bus[3] & in_bus[2] & in_bus[1] & in_bus[0]);

    // Product-of-Sums (POS) implementation
    assign out_pos = (in_bus[3] | in_bus[2] | ~in_bus[1] | in_bus[0]) &
                     (in_bus[3] | ~in_bus[2] | ~in_bus[1] | ~in_bus[0]) &
                     (~in_bus[3] | in_bus[2] | in_bus[1] | in_bus[0]);

endmodule