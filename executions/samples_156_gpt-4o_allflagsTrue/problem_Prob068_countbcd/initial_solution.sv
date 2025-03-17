module TopModule (
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    logic [3:0] ones_digit, tens_digit, hundreds_digit, thousands_digit;

    // Sequential logic for ones digit
    always @(posedge clk) begin
        if (reset) begin
            ones_digit <= 4'b0000;
        end else if (ones_digit == 4'b1001) begin
            ones_digit <= 4'b0000;
        end else begin
            ones_digit <= ones_digit + 1'b1;
        end
    end

    // Enable signal for tens digit
    always @(*) begin
        ena[0] = (ones_digit == 4'b1001);
    end

    // Sequential logic for tens digit
    always @(posedge clk) begin
        if (reset) begin
            tens_digit <= 4'b0000;
        end else if (ena[0]) begin
            if (tens_digit == 4'b1001) begin
                tens_digit <= 4'b0000;
            end else begin
                tens_digit <= tens_digit + 1'b1;
            end
        end
    end

    // Enable signal for hundreds digit
    always @(*) begin
        ena[1] = (tens_digit == 4'b1001) && (ones_digit == 4'b0000);
    end

    // Sequential logic for hundreds digit
    always @(posedge clk) begin
        if (reset) begin
            hundreds_digit <= 4'b0000;
        end else if (ena[1]) begin
            if (hundreds_digit == 4'b1001) begin
                hundreds_digit <= 4'b0000;
            end else begin
                hundreds_digit <= hundreds_digit + 1'b1;
            end
        end
    end

    // Enable signal for thousands digit
    always @(*) begin
        ena[2] = (hundreds_digit == 4'b1001) && (tens_digit == 4'b0000) && (ones_digit == 4'b0000);
    end

    // Sequential logic for thousands digit
    always @(posedge clk) begin
        if (reset) begin
            thousands_digit <= 4'b0000;
        end else if (ena[2]) begin
            if (thousands_digit == 4'b1001) begin
                thousands_digit <= 4'b0000;
            end else begin
                thousands_digit <= thousands_digit + 1'b1;
            end
        end
    end

    // Assign the digits to the output q
    assign q[3:0] = ones_digit;
    assign q[7:4] = tens_digit;
    assign q[11:8] = hundreds_digit;
    assign q[15:12] = thousands_digit;

endmodule