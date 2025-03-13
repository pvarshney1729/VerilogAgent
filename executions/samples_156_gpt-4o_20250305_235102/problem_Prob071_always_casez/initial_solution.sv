```verilog
[BEGIN]
module TopModule(
    input  logic [7:0] in,
    output logic [2:0] pos
);

    always @(*) begin
        pos = 3'b000; // Default value for pos
        casez (in)
            8'b00000001: pos = 3'd0;
            8'b0000001?: pos = 3'd1;
            8'b000001??: pos = 3'd2;
            8'b00001???: pos = 3'd3;
            8'b0001????: pos = 3'd4;
            8'b001?????: pos = 3'd5;
            8'b01??????: pos = 3'd6;
            8'b1???????: pos = 3'd7;
            default:     pos = 3'b000; // Explicitly handling all-zero case
        endcase
    end

endmodule
[DONE]
```