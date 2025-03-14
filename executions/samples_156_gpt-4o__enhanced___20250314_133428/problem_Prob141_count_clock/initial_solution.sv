module TopModule (
    input logic clk,          // Fast-running clock signal
    input logic reset,        // Active high synchronous reset
    input logic ena,          // Enable signal, pulses once per second
    output logic pm,          // AM/PM indicator (0 for AM, 1 for PM)
    output logic [7:0] hh,    // Hours in BCD, range 01-12
    output logic [7:0] mm,    // Minutes in BCD, range 00-59
    output logic [7:0] ss     // Seconds in BCD, range 00-59
);

    // Internal signals for BCD counting
    logic [3:0] hh_units, hh_tens;
    logic [3:0] mm_units, mm_tens;
    logic [3:0] ss_units, ss_tens;

    // Sequential logic for clock counting
    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00:00 AM
            hh_units <= 4'd2;
            hh_tens <= 4'd1;
            mm_units <= 4'd0;
            mm_tens <= 4'd0;
            ss_units <= 4'd0;
            ss_tens <= 4'd0;
            pm <= 1'b0;
        end else if (ena) begin
            // Increment seconds
            if (ss_units == 4'd9) begin
                ss_units <= 4'd0;
                if (ss_tens == 4'd5) begin
                    ss_tens <= 4'd0;
                    // Increment minutes
                    if (mm_units == 4'd9) begin
                        mm_units <= 4'd0;
                        if (mm_tens == 4'd5) begin
                            mm_tens <= 4'd0;
                            // Increment hours
                            if (hh_units == 4'd9 || (hh_tens == 4'd1 && hh_units == 4'd2)) begin
                                hh_units <= 4'd1;
                                hh_tens <= (hh_tens == 4'd1) ? 4'd0 : hh_tens;
                                pm <= ~pm; // Toggle AM/PM
                            end else begin
                                hh_units <= hh_units + 4'd1;
                            end
                        end else begin
                            mm_tens <= mm_tens + 4'd1;
                        end
                    end else begin
                        mm_units <= mm_units + 4'd1;
                    end
                end else begin
                    ss_tens <= ss_tens + 4'd1;
                end
            end else begin
                ss_units <= ss_units + 4'd1;
            end
        end
    end

    // Assign BCD values to outputs
    assign hh = {hh_tens, hh_units};
    assign mm = {mm_tens, mm_units};
    assign ss = {ss_tens, ss_units};

endmodule