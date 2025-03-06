module TopModule (
    input logic in_bit,
    output logic out_bit
);
    assign out_bit = ~in_bit; // Implementing NOT operation
endmodule