module TopModule(
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    // Internal registers for each BCD digit
    logic [3:0] ones, tens, hundreds, thousands;

    // Sequential logic for BCD counter with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            ones <= 4'd0;
            tens <= 4'd0;
            hundreds <= 4'd0;
            thousands <= 4'd0;
        end else begin
            // Increment logic for ones digit
            if (ones == 4'd9) begin
                ones <= 4'd0;
                // Handle carry to tens digit
                if (tens == 4'd9) begin
                    tens <= 4'd0;
                    // Handle carry to hundreds digit
                    if (hundreds == 4'd9) begin
                        hundreds <= 4'd0;
                        // Handle carry to thousands digit
                        if (thousands == 4'd9) begin
                            thousands <= 4'd0;
                        end else begin
                            thousands <= thousands + 4'd1;
                        end
                    end else begin
                        hundreds <= hundreds + 4'd1;
                    end
                end else begin
                    tens <= tens + 4'd1;
                end
            end else begin
                ones <= ones + 4'd1;
            end
        end
    end

    // Assign output q from individual BCD digits
    assign q = {thousands, hundreds, tens, ones};

    // Combinational logic for enable signals
    always_comb begin
        ena[0] = (ones == 4'd9);       // Enable for tens digit
        ena[1] = (tens == 4'd9) && ena[0];  // Enable for hundreds digit
        ena[2] = (hundreds == 4'd9) && ena[1]; // Enable for thousands digit
    end

endmodule