module TopModule (
    input logic clk,              // Clock input
    input logic reset,            // Synchronous active-high reset
    output logic [2:0] ena,       // Enable signals for tens, hundreds, and thousands digits
    output logic [15:0] q         // 4-digit BCD counter output
);

    logic [3:0] ones, tens, hundreds, thousands;

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 16'b0;
            ena <= 3'b0;
        end else begin
            // Increment ones digit
            if (ones == 4'd9) begin
                ones <= 4'd0;
                ena[0] <= 1'b1;
            end else begin
                ones <= ones + 1;
                ena[0] <= 1'b0;
            end

            // Increment tens digit
            if (ena[0]) begin
                if (tens == 4'd9) begin
                    tens <= 4'd0;
                    ena[1] <= 1'b1;
                end else begin
                    tens <= tens + 1;
                    ena[1] <= 1'b0;
                end
            end

            // Increment hundreds digit
            if (ena[1]) begin
                if (hundreds == 4'd9) begin
                    hundreds <= 4'd0;
                    ena[2] <= 1'b1;
                end else begin
                    hundreds <= hundreds + 1;
                    ena[2] <= 1'b0;
                end
            end

            // Increment thousands digit
            if (ena[2]) begin
                if (thousands == 4'd9) begin
                    thousands <= 4'd0;
                end else begin
                    thousands <= thousands + 1;
                end
            end

            // Update the BCD counter output
            q <= {thousands, hundreds, tens, ones};
        end
    end

endmodule