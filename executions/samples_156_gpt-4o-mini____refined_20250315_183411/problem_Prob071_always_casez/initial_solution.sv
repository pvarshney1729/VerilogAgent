[BEGIN]
```verilog
module TopModule (
    input logic [7:0] in,
    output logic [2:0] pos
);

    always @(*) begin
        pos = 3'b000; // Default to zero for no bits high
        casez (in)
            8'b1??????? : pos = 3'b111; // 7
            8'b01?????? : pos = 3'b110; // 6
            8'b001????? : pos = 3'b101; // 5
            8'b0001???? : pos = 3'b100; // 4
            8'b00001??? : pos = 3'b011; // 3
            8'b000001?? : pos = 3'b010; // 2
            8'b0000001? : pos = 3'b001; // 1
            8'b00000001 : pos = 3'b000; // 0
            default: pos = 3'b000; // No bits are high
        endcase
    end

endmodule
```
[DONE]