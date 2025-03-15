module TopModule (
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    // Internal signals for each BCD digit
    logic [3:0] ones, tens, hundreds, thousands;

    // Enable signals for each BCD digit
    assign ena[0] = (ones == 4'd9);
    assign ena[1] = (tens == 4'd9) && ena[0];
    assign ena[2] = (hundreds == 4'd9) && ena[1];

    // Concatenate BCD digits to form the output q
    assign q = {thousands, hundreds, tens, ones};

    // Sequential logic for BCD counter
    always_ff @(posedge clk) begin
        if (reset) begin
            ones <= 4'd0;
            tens <= 4'd0;
            hundreds <= 4'd0;
            thousands <= 4'd0;
        end else begin
            // Increment ones digit
            if (ones == 4'd9) begin
                ones <= 4'd0;
                // Increment tens digit
                if (tens == 4'd9) begin
                    tens <= 4'd0;
                    // Increment hundreds digit
                    if (hundreds == 4'd9) begin
                        hundreds <= 4'd0;
                        // Increment thousands digit
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

endmodule