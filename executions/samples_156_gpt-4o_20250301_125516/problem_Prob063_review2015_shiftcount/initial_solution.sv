```verilog
module TopModule (
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    // Internal register to hold the state of the shift register
    logic [3:0] q_reg;

    // Asynchronous reset to initialize the register to 4'b0000
    initial begin
        q_reg = 4'b0000;
    end

    // Sequential logic for shift register and counter
    always_ff @(posedge clk) begin
        if (shift_ena && !count_ena) begin
            // Shift operation
            q_reg <= {data, q_reg[3:1]};
        end else if (!shift_ena && count_ena) begin
            // Count operation
            q_reg <= q_reg - 1;
        end
        // If both shift_ena and count_ena are high, behavior is unspecified
    end

    // Assign the internal register to the output
    assign q = q_reg;

endmodule
```