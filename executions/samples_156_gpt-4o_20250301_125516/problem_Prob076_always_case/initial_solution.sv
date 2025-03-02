```verilog
module TopModule (
    input  logic [2:0] sel,   // 3-bit input selector, unsigned
    input  logic [3:0] data0, // 4-bit input data line 0
    input  logic [3:0] data1, // 4-bit input data line 1
    input  logic [3:0] data2, // 4-bit input data line 2
    input  logic [3:0] data3, // 4-bit input data line 3
    input  logic [3:0] data4, // 4-bit input data line 4
    input  logic [3:0] data5, // 4-bit input data line 5
    output logic [3:0] out    // 4-bit output, unsigned
);

always @(*) begin
    case(sel)
        3'd0: out = data0;
        3'd1: out = data1;
        3'd2: out = data2;
        3'd3: out = data3;
        3'd4: out = data4;
        3'd5: out = data5;
        default: out = 4'b0000; // Output 0 for any sel > 5
    endcase
end

endmodule
```