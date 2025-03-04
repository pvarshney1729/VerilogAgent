```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    input logic y,
    output logic z
);
    always @(posedge clk) begin
        if (reset) begin
            z <= 1;
        end else begin
            case ({x, y})
                2'b00: z <= 1;
                2'b01: z <= 0;
                2'b10: z <= 0;
                2'b11: z <= 1;
                default: z <= 1; // Default case for safety
            endcase
        end
    end
endmodule
```