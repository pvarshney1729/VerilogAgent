module TopModule (
    input logic clk,        // 1-bit clock signal
    input logic reset,      // 1-bit synchronous active-high reset
    output logic [2:0] ena, // 3-bit enable signal
    output logic [15:0] q   // 16-bit BCD counter output
);

    // Internal registers for BCD digits
    logic [3:0] ones, tens, hundreds, thousands;

    // Sequential logic for BCD counter
    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset all BCD digits and enable signals
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
            thousands <= 4'b0000;
            ena <= 3'b000;
        end else begin
            // Increment ones digit
            if (ones == 4'd9) begin
                ones <= 4'b0000;
                ena[0] <= 1'b1;
            end else begin
                ones <= ones + 1'b1;
                ena[0] <= 1'b0;
            end

            // Increment tens digit
            if (ena[0]) begin
                if (tens == 4'd9) begin
                    tens <= 4'b0000;
                    ena[1] <= 1'b1;
                end else begin
                    tens <= tens + 1'b1;
                    ena[1] <= 1'b0;
                end
            end

            // Increment hundreds digit
            if (ena[1]) begin
                if (hundreds == 4'd9) begin
                    hundreds <= 4'b0000;
                    ena[2] <= 1'b1;
                end else begin
                    hundreds <= hundreds + 1'b1;
                    ena[2] <= 1'b0;
                end
            end

            // Increment thousands digit
            if (ena[2]) begin
                if (thousands == 4'd9) begin
                    thousands <= 4'b0000;
                end else begin
                    thousands <= thousands + 1'b1;
                end
            end
        end
    end

    // Concatenate BCD digits to form the output
    always_comb begin
        q = {thousands, hundreds, tens, ones};
    end

endmodule