```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    // Internal register to hold the state of the shift register/counter
    logic [3:0] shift_reg;

    // Synchronous reset and operation logic
    always_ff @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0000; // Initialize to zero on reset
        end else begin
            if (shift_ena && !count_ena) begin
                // Shift operation
                shift_reg <= {shift_reg[2:0], data};
            end else if (!shift_ena && count_ena) begin
                // Count operation
                shift_reg <= shift_reg - 4'b0001;
            end
        end
    end

    // Assign the internal register to the output
    assign q = shift_reg;

endmodule
[DONE]
```