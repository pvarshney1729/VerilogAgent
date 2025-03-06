```verilog
module TopModule (
    input  [3:0] abcd,
    output logic out_sop,
    output logic out_pos
);
    always @(*) begin
        out_sop = (abcd == 4'b0010) || (abcd == 4'b0111) || (abcd == 4'b1111);
        out_pos = ~((abcd == 4'b0000) || (abcd == 4'b0001) || (abcd == 4'b0100) ||
                     (abcd == 4'b0101) || (abcd == 4'b0110) || (abcd == 4'b1001) ||
                     (abcd == 4'b1010) || (abcd == 4'b1101) || (abcd == 4'b1110));
    end
endmodule
```