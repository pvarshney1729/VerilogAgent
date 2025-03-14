module TopModule (
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    logic [3:0] ones, tens, hundreds, thousands;

    always @(posedge clk) begin
        if (reset) begin
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
            thousands <= 4'b0000;
            ena <= 3'b000;
        end else begin
            ena <= 3'b000; // Reset enables

            // Update 'ones' digit
            if (ones == 4'b1001) begin
                ones <= 4'b0000;
                ena[0] <= 1; // Enable tens increment
                // Update 'tens' digit
                if (tens == 4'b1001) begin
                    tens <= 4'b0000;
                    ena[1] <= 1; // Enable hundreds increment
                    // Update 'hundreds' digit
                    if (hundreds == 4'b1001) begin
                        hundreds <= 4'b0000;
                        ena[2] <= 1; // Enable thousands increment
                        // Update 'thousands' digit
                        if (thousands < 4'b1001) begin
                            thousands <= thousands + 1;
                        end
                    end else begin
                        hundreds <= hundreds + 1;
                    end
                end else begin
                    tens <= tens + 1;
                end
            end else begin
                ones <= ones + 1;
            end
        end
    end

    // Combine digits into output q
    always @(*) begin
        q = {thousands, hundreds, tens, ones};
    end

endmodule