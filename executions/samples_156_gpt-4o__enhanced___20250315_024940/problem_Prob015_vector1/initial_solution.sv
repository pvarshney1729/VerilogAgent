module TopModule (
    input  logic [15:0] in,
    output logic [7:0] out_hi,
    output logic [7:0] out_lo
);

    always @(*) begin
        out_hi = in[15:8]; // Assign upper byte
        out_lo = in[7:0];  // Assign lower byte
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly