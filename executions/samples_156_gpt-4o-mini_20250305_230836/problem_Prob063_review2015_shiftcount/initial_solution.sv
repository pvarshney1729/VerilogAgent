```verilog
module TopModule (
    input logic clk,
    input logic reset, // Added reset signal
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    logic [3:0] shift_reg;

    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0000; // Reset state
        end else begin
            if (shift_ena && !count_ena) begin
                shift_reg <= {data, shift_reg[3:1]}; // Shift left and load data
            end else if (!shift_ena && count_ena) begin
                shift_reg <= shift_reg - 4'b0001; // Decrement
            end
            // If both are high, maintain current state (no operation)
        end
    end

    assign q = shift_reg;

endmodule
```