[BEGIN]
module TopModule (
    input  logic [15:0] in,
    output logic [7:0] out_hi,
    output logic [7:0] out_lo
);

    always @(*) begin
        out_hi = in[15:8]; // Upper byte
        out_lo = in[7:0];  // Lower byte
    end

endmodule
[DONE]