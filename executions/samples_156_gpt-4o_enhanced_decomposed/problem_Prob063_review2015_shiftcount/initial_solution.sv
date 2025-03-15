module TopModule(
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    // Internal register to hold the current state
    logic [3:0] shift_reg;

    // Sequential logic to update the shift register
    always_ff @(posedge clk) begin
        if (shift_ena) begin
            // Shift in the data bit into the MSB
            shift_reg <= {data, shift_reg[3:1]};
        end else if (count_ena) begin
            // Decrement the current value
            shift_reg <= shift_reg - 1;
        end
        // If both shift_ena and count_ena are high, behavior is unspecified
    end

    // Assign the internal register to the output
    assign q = shift_reg;

endmodule