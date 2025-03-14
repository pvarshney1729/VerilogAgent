```verilog
module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);
    always @(*) begin
        case ({c, d}) 
            2'b00: mux_in = 4'b0000; // ab = 00
            2'b01: mux_in = 4'b0001; // ab = 01
            2'b10: mux_in = 4'b0011; // ab = 10
            2'b11: mux_in = 4'b0011; // ab = 11
            default: mux_in = 4'b0000; // default case
        endcase
    end
endmodule
```