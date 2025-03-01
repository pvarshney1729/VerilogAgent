```verilog
module TopModule (
    input  wire [2:0] sel,     // 3-bit selection signal
    input  wire [3:0] data0,   // 4-bit data input 0
    input  wire [3:0] data1,   // 4-bit data input 1
    input  wire [3:0] data2,   // 4-bit data input 2
    input  wire [3:0] data3,   // 4-bit data input 3
    input  wire [3:0] data4,   // 4-bit data input 4
    input  wire [3:0] data5,   // 4-bit data input 5
    output reg  [3:0] out      // 4-bit output
);

always @(*) begin
    case (sel)
        3'd0: out = data0;
        3'd1: out = data1;
        3'd2: out = data2;
        3'd3: out = data3;
        3'd4: out = data4;
        3'd5: out = data5;
        default: out = 4'b0000;
    endcase
end

endmodule
```