```verilog
module TopModule (
    input logic clk,           // Clock signal, positive edge-triggered
    input logic reset,         // Synchronous active-high reset
    input logic ena,           // Enable signal for counting
    output logic pm,           // 1-bit output, 1 for PM, 0 for AM
    output logic [7:0] hh,     // 8-bit BCD output for hours (01-12)
    output logic [7:0] mm,     // 8-bit BCD output for minutes (00-59)
    output logic [7:0] ss      // 8-bit BCD output for seconds (00-59)
);

    // Internal signals for BCD counting
    logic [3:0] hh_units, hh_tens;
    logic [3:0] mm_units, mm_tens;
    logic [3:0] ss_units, ss_tens;

    // Initial state
    initial begin
        hh = 8'b0001_0010; // 12
        mm = 8'b0000_0000; // 00
        ss = 8'b0000_0000; // 00
        pm = 0;            // AM
    end

    // Sequential logic for clock counting
    always_ff @(posedge clk) begin
        if (reset) begin
            hh <= 8'b0001_0010; // 12
            mm <= 8'b0000_0000; // 00
            ss <= 8'b0000_0000; // 00
            pm <= 0;            // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b0101_1001) begin // 59
                ss <= 8'b0000_0000; // Reset to 00
                // Increment minutes
                if (mm == 8'b0101_1001) begin // 59
                    mm <= 8'b0000_0000; // Reset to 00
                    // Increment hours
                    if (hh == 8'b0001_0010) begin // 12
                        hh <= 8'b0000_0001; // Reset to 01
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'b0001_0001) begin // 11
                        hh <= 8'b0001_0010; // Go to 12
                    end else begin
                        hh_units = hh[3:0];
                        hh_tens = hh[7:4];
                        if (hh_units == 4'b1001) begin // 9
                            hh_units <= 4'b0000; // Reset units to 0
                            hh_tens <= hh_tens + 1; // Increment tens
                        end else begin
                            hh_units <= hh_units + 1; // Increment units
                        end
                        hh <= {hh_tens, hh_units};
                    end
                end else begin
                    mm_units = mm[3:0];
                    mm_tens = mm[7:4];
                    if (mm_units == 4'b1001) begin // 9
                        mm_units <= 4'b0000; // Reset units to 0
                        mm_tens <= mm_tens + 1; // Increment tens
                    end else begin
                        mm_units <= mm_units + 1; // Increment units
                    end
                    mm <= {mm_tens, mm_units};
                end
            end else begin
                ss_units = ss[3:0];
                ss_tens = ss[7:4];
                if (ss_units == 4'b1001) begin // 9
                    ss_units <= 4'b0000; // Reset units to 0
                    ss_tens <= ss_tens + 1; // Increment tens
                end else begin
                    ss_units <= ss_units + 1; // Increment units
                end
                ss <= {ss_tens, ss_units};
            end
        end
    end

endmodule
```