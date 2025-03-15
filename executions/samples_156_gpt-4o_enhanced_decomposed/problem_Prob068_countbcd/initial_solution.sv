module TopModule(
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    // Internal registers for BCD digits
    logic [3:0] ones, tens, hundreds, thousands;

    // Sequential logic for BCD counter
    always_ff @(posedge clk) begin
        if (reset) begin
            // Synchronous reset
            ones <= 4'd0;
            tens <= 4'd0;
            hundreds <= 4'd0;
            thousands <= 4'd0;
        end else begin
            // Increment ones digit
            if (ones == 4'd9) begin
                ones <= 4'd0;
                // Enable tens digit increment
                if (tens == 4'd9) begin
                    tens <= 4'd0;
                    // Enable hundreds digit increment
                    if (hundreds == 4'd9) begin
                        hundreds <= 4'd0;
                        // Enable thousands digit increment
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

    // Assign output q
    assign q = {thousands, hundreds, tens, ones};

    // Generate enable signals
    assign ena[0] = (ones == 4'd9);
    assign ena[1] = (ena[0] && tens == 4'd9);
    assign ena[2] = (ena[1] && hundreds == 4'd9);

endmodule