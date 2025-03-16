[BEGIN]
module TopModule(
    input logic [3:0] in,
    output logic [2:0] out_both,
    output logic [2:0] out_any,
    output logic [3:0] out_different
);

    always @(*) begin
        // out_both logic: out_both[i] = in[i] & in[i+1] for i = 0, 1, 2
        out_both[0] = in[0] & in[1];
        out_both[1] = in[1] & in[2];
        out_both[2] = in[2] & in[3];
        
        // out_any logic: out_any[i] = in[i] | in[i-1] for i = 1, 2, 3
        out_any[0] = in[1] | in[0];
        out_any[1] = in[2] | in[1];
        out_any[2] = in[3] | in[2];
        
        // out_different logic: out_different[i] = in[i] ^ in[(i+1) % 4] for i = 0, 1, 2, 3
        out_different[0] = in[0] ^ in[1];
        out_different[1] = in[1] ^ in[2];
        out_different[2] = in[2] ^ in[3];
        out_different[3] = in[3] ^ in[0];
    end

endmodule
[DONE]