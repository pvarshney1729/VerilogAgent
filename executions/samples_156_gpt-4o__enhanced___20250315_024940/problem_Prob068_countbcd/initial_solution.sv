module TopModule (
    input  logic clk,
    input  logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);
    // BCD counter registers
    logic [3:0] ones, tens, hundreds, thousands;

    always @(posedge clk) begin
        if (reset) begin
            // Synchronous reset
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
            thousands <= 4'b0000;
        end else begin
            // Increment ones digit
            if (ones == 4'b1001) begin // If ones digit is 9
                ones <= 4'b0000; // Reset ones
                if (tens == 4'b1001) begin // If tens digit is 9
                    tens <= 4'b0000; // Reset tens
                    if (hundreds == 4'b1001) begin // If hundreds digit is 9
                        hundreds <= 4'b0000; // Reset hundreds
                        if (thousands == 4'b1001) begin // If thousands digit is 9
                            thousands <= 4'b0000; // Reset thousands
                        end else begin
                            thousands <= thousands + 1; // Increment thousands
                        end
                    end else begin
                        hundreds <= hundreds + 1; // Increment hundreds
                    end
                end else begin
                    tens <= tens + 1; // Increment tens
                end
            end else begin
                ones <= ones + 1; // Increment ones
            end
        end
    end

    // Assign outputs
    assign q = {thousands, hundreds, tens, ones};
    assign ena[0] = (ones == 4'b1001);      // Enable for tens
    assign ena[1] = (tens == 4'b1001);      // Enable for hundreds
    assign ena[2] = (hundreds == 4'b1001);  // Enable for thousands

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly