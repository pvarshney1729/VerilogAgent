```verilog
module TopModule(
    input logic [3:0] in_bus,
    output logic out_sop,
    output logic out_pos
);

    // Minimum Sum-of-Products (SOP) form
    assign out_sop = (in_bus == 4'd2) || (in_bus == 4'd7) || (in_bus == 4'd15);

    // Minimum Product-of-Sums (POS) form
    assign out_pos = (in_bus == 4'd2) || (in_bus == 4'd7) || (in_bus == 4'd15);

endmodule
```