[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic shift_ena,
    input  logic count_ena,
    input  logic data,
    output logic [3:0] q
);

    logic [3:0] shift_reg;

    always @(posedge clk) begin
        if (shift_ena) begin
            shift_reg <= {shift_reg[2:0], data}; // Shift in data
        end else if (count_ena) begin
            shift_reg <= shift_reg - 4'b0001; // Decrement the counter
        end
    end

    always @(*) begin
        q = shift_reg; // Combinational logic for output
    end

endmodule
```
[DONE]