module TopModule (
    input  logic [2:0] sel,   // 3-bit selector input to choose one of the data inputs
    input  logic [3:0] data0, // 4-bit data input 0
    input  logic [3:0] data1, // 4-bit data input 1
    input  logic [3:0] data2, // 4-bit data input 2
    input  logic [3:0] data3, // 4-bit data input 3
    input  logic [3:0] data4, // 4-bit data input 4
    input  logic [3:0] data5, // 4-bit data input 5
    output logic [3:0] out    // 4-bit output of the multiplexer
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