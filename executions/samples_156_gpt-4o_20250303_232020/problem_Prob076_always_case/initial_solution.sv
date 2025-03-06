module TopModule (
    input  logic [2:0] sel,     // 3-bit selector, unsigned
    input  logic [3:0] data0,   // 4-bit input, unsigned
    input  logic [3:0] data1,   // 4-bit input, unsigned
    input  logic [3:0] data2,   // 4-bit input, unsigned
    input  logic [3:0] data3,   // 4-bit input, unsigned
    input  logic [3:0] data4,   // 4-bit input, unsigned
    input  logic [3:0] data5,   // 4-bit input, unsigned
    output logic [3:0] out      // 4-bit output, unsigned
);

    always @(*) begin
        case (sel)
            3'b000: out = data0;
            3'b001: out = data1;
            3'b010: out = data2;
            3'b011: out = data3;
            3'b100: out = data4;
            3'b101: out = data5;
            default: out = 4'b0000;
        endcase
    end

endmodule