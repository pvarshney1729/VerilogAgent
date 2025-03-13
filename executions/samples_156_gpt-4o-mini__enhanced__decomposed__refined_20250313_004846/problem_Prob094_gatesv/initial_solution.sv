```verilog
module TopModule(
    input  [3:0] in,
    output logic [2:0] out_both,
    output logic [3:1] out_any,
    output logic [3:0] out_different
);

    always @(*) begin
        // out_both logic
        out_both[0] = in[0] & in[1]; // 1'b0
        out_both[1] = in[1] & in[2]; // 1'b1
        out_both[2] = in[2] & in[3]; // 1'b1

        // out_any logic
        out_any[1] = in[1] | in[0]; // 1'b0
        out_any[2] = in[2] | in[1]; // 1'b1
        out_any[3] = in[3] | in[2]; // 1'b1

        // out_different logic
        out_different[0] = in[0] ^ in[3]; // 1'b0
        out_different[1] = in[1] ^ in[0]; // 1'b1
        out_different[2] = in[2] ^ in[1]; // 1'b1
        out_different[3] = in[3] ^ in[2]; // 1'b1
    end

endmodule
```