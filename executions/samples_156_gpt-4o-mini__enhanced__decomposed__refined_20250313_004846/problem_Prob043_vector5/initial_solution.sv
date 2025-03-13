[BEGIN]
module TopModule (
    input logic a,  // 1-bit input
    input logic b,  // 1-bit input
    input logic c,  // 1-bit input
    input logic d,  // 1-bit input
    input logic e,  // 1-bit input
    output logic [24:0] out  // 25-bit output: out[24] is MSB, out[0] is LSB
);

    always @(*) begin
        out[24] = a ~^ a;  // Self-comparison
        out[23] = a ~^ b;
        out[22] = a ~^ c;
        out[21] = a ~^ d;
        out[20] = a ~^ e;
        out[19] = b ~^ a;
        out[18] = b ~^ b;  // Self-comparison
        out[17] = b ~^ c;
        out[16] = b ~^ d;
        out[15] = b ~^ e;
        out[14] = c ~^ a;
        out[13] = c ~^ b;
        out[12] = c ~^ c;  // Self-comparison
        out[11] = c ~^ d;
        out[10] = c ~^ e;
        out[9]  = d ~^ a;
        out[8]  = d ~^ b;
        out[7]  = d ~^ c;
        out[6]  = d ~^ d;  // Self-comparison
        out[5]  = d ~^ e;
        out[4]  = e ~^ a;
        out[3]  = e ~^ b;
        out[2]  = e ~^ c;
        out[1]  = e ~^ d;
        out[0]  = e ~^ e;  // Self-comparison
    end

endmodule
[DONE]