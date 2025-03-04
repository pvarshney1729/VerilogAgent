module TopModule (
    input logic a,           // 1-bit input signal 'a'
    input logic b,           // 1-bit input signal 'b'
    output logic out_assign, // 1-bit output signal from assign statement
    output logic out_alwaysblock // 1-bit output signal from always block
);

    // AND operation using assign statement
    assign out_assign = a & b;

    // AND operation using an always block
    always @* begin
        out_alwaysblock = a & b;
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly