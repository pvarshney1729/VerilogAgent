module combinational_logic (
    input logic [99:0] in_vector,
    input logic clk,
    input logic rst_n,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    always @(*) begin
        out_both = in_vector & in_vector; // Both bits are the same
        out_any = in_vector | in_vector;  // Any bit is high
        out_different = in_vector ^ in_vector; // Different bits
    end

endmodule