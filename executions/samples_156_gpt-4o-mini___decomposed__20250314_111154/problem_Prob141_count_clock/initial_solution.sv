module TopModule (
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    // Internal registers to count seconds, minutes, and hours
    logic [3:0] seconds_tens;
    logic [3:0] seconds_units;
    logic [3:0] minutes_tens;
    logic [3:0] minutes_units;
    logic [3:0] hours_tens;
    logic [3:0] hours_units;

    always @(posedge clk) begin
        if (reset) begin
            // Reset all counters and pm indicator
            hours_tens <= 4'd1; // Start from 01
            hours_units <= 4'd0; // Start from 00
            minutes_tens <= 4'd0; // Start from 00
            minutes_units <= 4'd0; // Start from 00
            seconds_tens <= 4'd0; // Start from 00
            seconds_units <= 4'd0; // Start from 00
            pm <= 1'b0; // Start as AM
        end else if (ena) begin
            // Increment seconds
            if (seconds_units == 4'd9) begin
                seconds_units <= 4'd0; // Reset seconds units
                if (seconds_tens == 4'd5) begin
                    seconds_tens <= 4'd0; // Reset seconds tens
                    // Increment minutes
                    if (minutes_units == 4'd9) begin
                        minutes_units <= 4'd0; // Reset minutes units
                        if (minutes_tens == 4'd5) begin
                            minutes_tens <= 4'd0; // Reset minutes tens
                            // Increment hours
                            if (hours_units == 4'd9 && hours_tens == 4'd1) begin
                                hours_units <= 4'd0; // Reset hours units
                                hours_tens <= 4'd0; // Reset hours tens
                                pm <= ~pm; // Toggle AM/PM
                            end else if (hours_units == 4'd9) begin
                                hours_units <= 4'd0; // Reset hours units
                                hours_tens <= hours_tens + 4'd1; // Increment hours tens
                            end else begin
                                hours_units <= hours_units + 4'd1; // Increment hours units
                            end
                        end else begin
                            minutes_tens <= minutes_tens + 4'd1; // Increment minutes tens
                        end
                    end else begin
                        minutes_units <= minutes_units + 4'd1; // Increment minutes units
                    end
                end else begin
                    seconds_units <= seconds_units + 4'd1; // Increment seconds units
                end
            end else begin
                seconds_units <= seconds_units + 4'd1; // Increment seconds units
            end
        end
    end

    // Assign outputs
    always @(posedge clk) begin
        hh <= {hours_tens, hours_units}; // Convert hour_count to 8-bit
        mm <= {minutes_tens, minutes_units}; // Convert min_count to 8-bit
        ss <= {seconds_tens, seconds_units}; // Convert sec_count to 8-bit
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly