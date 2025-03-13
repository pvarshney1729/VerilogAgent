```verilog
[BEGIN]
module TopModule (
    input  logic [3:0] in,  // 4-bit input vector
    output logic [1:0] pos  // 2-bit output encoding position of first '1'
);

    always @(*) begin
        casez (in)
            4'b1???: pos = 2'b11; // in[3] is '1'
            4'b01??: pos = 2'b10; // in[2] is '1'
            4'b001?: pos = 2'b01; // in[1] is '1'
            4'b0001: pos = 2'b00; // in[0] is '1'
            default: pos = 2'b00; // all zeros
        endcase
    end

endmodule
[DONE]
```