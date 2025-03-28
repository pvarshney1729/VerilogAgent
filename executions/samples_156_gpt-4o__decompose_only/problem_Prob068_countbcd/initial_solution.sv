module TopModule (
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    // Internal registers for each BCD digit
    logic [3:0] ones_digit;
    logic [3:0] tens_digit;
    logic [3:0] hundreds_digit;
    logic [3:0] thousands_digit;

    // Synchronous reset and BCD counter logic
    always @(posedge clk) begin
        if (reset) begin
            // Reset all digits to 0
            ones_digit <= 4'b0000;
            tens_digit <= 4'b0000;
            hundreds_digit <= 4'b0000;
            thousands_digit <= 4'b0000;
            ena <= 3'b000;
        end else begin
            // Increment ones digit
            if (ones_digit == 4'b1001) begin
                ones_digit <= 4'b0000;
                ena[0] <= 1'b1; // Enable tens digit increment
            end else begin
                ones_digit <= ones_digit + 1;
                ena[0] <= 1'b0;
            end

            // Increment tens digit
            if (ena[0]) begin
                if (tens_digit == 4'b1001) begin
                    tens_digit <= 4'b0000;
                    ena[1] <= 1'b1; // Enable hundreds digit increment
                end else begin
                    tens_digit <= tens_digit + 1;
                    ena[1] <= 1'b0;
                end
            end

            // Increment hundreds digit
            if (ena[1]) begin
                if (hundreds_digit == 4'b1001) begin
                    hundreds_digit <= 4'b0000;
                    ena[2] <= 1'b1; // Enable thousands digit increment
                end else begin
                    hundreds_digit <= hundreds_digit + 1;
                    ena[2] <= 1'b0;
                end
            end

            // Increment thousands digit
            if (ena[2]) begin
                if (thousands_digit == 4'b1001) begin
                    thousands_digit <= 4'b0000;
                end else begin
                    thousands_digit <= thousands_digit + 1;
                end
            end
        end
    end

    // Assign the BCD digits to the output q
    assign q[3:0] = ones_digit;
    assign q[7:4] = tens_digit;
    assign q[11:8] = hundreds_digit;
    assign q[15:12] = thousands_digit;

endmodule