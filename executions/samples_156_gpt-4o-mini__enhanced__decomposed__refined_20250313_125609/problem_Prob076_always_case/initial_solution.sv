```verilog
[BEGIN]
module TopModule (
    input logic [2:0] sel,         // 3-bit select signal
    input logic [3:0] data0,      // 4-bit data input 0
    input logic [3:0] data1,      // 4-bit data input 1
    input logic [3:0] data2,      // 4-bit data input 2
    input logic [3:0] data3,      // 4-bit data input 3
    input logic [3:0] data4,      // 4-bit data input 4
    input logic [3:0] data5,      // 4-bit data input 5
    output logic [3:0] out        // 4-bit output signal
);

always @(*) begin
    case (sel)
        3'b000: out = data0; // Select data0 when sel is 0
        3'b001: out = data1; // Select data1 when sel is 1
        3'b010: out = data2; // Select data2 when sel is 2
        3'b011: out = data3; // Select data3 when sel is 3
        3'b100: out = data4; // Select data4 when sel is 4
        3'b101: out = data5; // Select data5 when sel is 5
        default: out = 4'b0000; // Output 0 for sel > 5
    endcase
end

endmodule
[DONE]
```