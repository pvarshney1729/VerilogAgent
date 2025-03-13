[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    output logic shift_ena
);

    logic [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b000;
            shift_ena <= 1'b1;
        end else if (count < 3'b011) begin
            count <= count + 3'b001;
            shift_ena <= 1'b1;
        end else begin
            shift_ena <= 1'b0;
        end
    end

endmodule
```
[DONE]