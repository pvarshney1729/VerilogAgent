```verilog
module TopModule (
    input logic [3:0] x,
    output logic f
);

    always @(*) begin
        case (x)
            4'b0001, 4'b0100, 4'b0111, 4'b1000, 4'b1001, 4'b1010, 4'b1100, 4'b1101: f = 1'b1;
            4'b0000, 4'b0010, 4'b0101, 4'b1011: f = 1'b0;
            default: f = 1'b0; // Assigning don't-care conditions to 0 for simplicity
        endcase
    end

endmodule
```