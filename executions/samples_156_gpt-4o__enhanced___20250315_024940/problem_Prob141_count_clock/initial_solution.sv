module TopModule (
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    logic [3:0] sec_tens; // Tens place of seconds (0-5)
    logic [3:0] sec_units; // Units place of seconds (0-9)
    logic [3:0] min_tens; // Tens place of minutes (0-5)
    logic [3:0] min_units; // Units place of minutes (0-9)
    logic [3:0] hr_tens; // Tens place of hours (0-1)
    logic [3:0] hr_units; // Units place of hours (0-2)

    // BCD counters for seconds
    always @(posedge clk) begin
        if (reset) begin
            sec_tens <= 4'b0000;
            sec_units <= 4'b0000;
            min_tens <= 4'b0000;
            min_units <= 4'b0000;
            hr_tens <= 4'b0000;
            hr_units <= 4'b0001; // Start at 1 for 12-hour format
        end else if (ena) begin
            if (sec_units == 4'b1001) begin // 9
                sec_units <= 4'b0000;
                if (sec_tens == 4'b0101) begin // 5
                    sec_tens <= 4'b0000;
                    if (min_units == 4'b1001) begin // 9
                        min_units <= 4'b0000;
                        if (min_tens == 4'b0101) begin // 5
                            min_tens <= 4'b0000;
                            if (hr_units == 4'b0010 && hr_tens == 4'b0001) begin // 12
                                hr_tens <= 4'b0000; // Reset hours to 1
                                hr_units <= 4'b0001; // Set hours to 1
                                pm <= ~pm; // Toggle PM/AM
                            end else if (hr_units == 4'b0011 && hr_tens == 4'b0000) begin // 1-2
                                hr_units <= hr_units + 1;
                            end else if (hr_units == 4'b0001 && hr_tens == 4'b0000) begin // 1
                                hr_units <= 4'b0010; // Set hours to 2
                            end else begin
                                hr_units <= hr_units + 1;
                            end
                        end else begin
                            min_units <= min_units + 1;
                        end
                    end else begin
                        sec_tens <= sec_tens; // Keep the same tens
                    end
                end else begin
                    sec_units <= sec_units + 1;
                end
            end else begin
                sec_units <= sec_units; // Keep the same units
            end
        end
    end

    assign hh = {hr_tens, hr_units}; // Concatenate tens and units for hours
    assign mm = {min_tens, min_units}; // Concatenate tens and units for minutes
    assign ss = {sec_tens, sec_units}; // Concatenate tens and units for seconds

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly