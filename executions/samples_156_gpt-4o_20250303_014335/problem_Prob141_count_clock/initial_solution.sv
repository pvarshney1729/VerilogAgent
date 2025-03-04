module TopModule (
    input logic clk,              // Clock input, positive edge-triggered
    input logic reset,            // Active high synchronous reset
    input logic ena,              // Enable signal for clock increment
    output logic pm,              // AM/PM indicator, 1 for PM, 0 for AM
    output logic [7:0] hh,        // Hours as two BCD digits (01-12)
    output logic [7:0] mm,        // Minutes as two BCD digits (00-59)
    output logic [7:0] ss         // Seconds as two BCD digits (00-59)
);

    // Internal registers for time keeping
    logic [3:0] hh_ones, hh_tens;
    logic [3:0] mm_ones, mm_tens;
    logic [3:0] ss_ones, ss_tens;

    // Initialize the clock to 12:00:00 AM on reset
    always_ff @(posedge clk) begin
        if (reset) begin
            hh <= 8'b0001_0010; // 12
            mm <= 8'b0000_0000; // 00
            ss <= 8'b0000_0000; // 00
            pm <= 0;            // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b0101_1001) begin // 59
                ss <= 8'b0000_0000; // Reset seconds to 00
                // Increment minutes
                if (mm == 8'b0101_1001) begin // 59
                    mm <= 8'b0000_0000; // Reset minutes to 00
                    // Increment hours
                    if (hh == 8'b0001_0010) begin // 12
                        hh <= 8'b0000_0001; // Reset hours to 01
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'b0001_0001) begin // 11
                        hh <= 8'b0001_0010; // Increment to 12
                    end else begin
                        hh_ones = hh[3:0];
                        hh_tens = hh[7:4];
                        if (hh_ones == 4'b1001) begin
                            hh_ones <= 4'b0000;
                            hh_tens <= hh_tens + 1;
                        end else begin
                            hh_ones <= hh_ones + 1;
                        end
                        hh <= {hh_tens, hh_ones};
                    end
                end else begin
                    mm_ones = mm[3:0];
                    mm_tens = mm[7:4];
                    if (mm_ones == 4'b1001) begin
                        mm_ones <= 4'b0000;
                        mm_tens <= mm_tens + 1;
                    end else begin
                        mm_ones <= mm_ones + 1;
                    end
                    mm <= {mm_tens, mm_ones};
                end
            end else begin
                ss_ones = ss[3:0];
                ss_tens = ss[7:4];
                if (ss_ones == 4'b1001) begin
                    ss_ones <= 4'b0000;
                    ss_tens <= ss_tens + 1;
                end else begin
                    ss_ones <= ss_ones + 1;
                end
                ss <= {ss_tens, ss_ones};
            end
        end
    end
endmodule