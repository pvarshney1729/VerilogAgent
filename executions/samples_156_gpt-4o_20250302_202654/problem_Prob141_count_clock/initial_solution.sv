module TopModule(
    input logic clk,       // Clock signal, positive edge-triggered
    input logic reset,     // Active high synchronous reset
    input logic ena,       // Enable signal, triggers increment when high
    output logic pm,       // AM/PM indicator, 1 for PM, 0 for AM
    output logic [7:0] hh, // Hours (01-12), two BCD digits
    output logic [7:0] mm, // Minutes (00-59), two BCD digits
    output logic [7:0] ss  // Seconds (00-59), two BCD digits
);

    // Internal signals for BCD counting
    logic [3:0] hh_ones, hh_tens;
    logic [3:0] mm_ones, mm_tens;
    logic [3:0] ss_ones, ss_tens;

    // Initialize outputs
    initial begin
        pm = 0;
        hh = 8'b0001_0010; // 12 in BCD
        mm = 8'b0000_0000; // 00 in BCD
        ss = 8'b0000_0000; // 00 in BCD
    end

    // Sequential logic for clock operation
    always_ff @(posedge clk) begin
        if (reset) begin
            // Synchronous reset to 12:00:00 AM
            pm <= 0;
            hh <= 8'b0001_0010; // 12 in BCD
            mm <= 8'b0000_0000; // 00 in BCD
            ss <= 8'b0000_0000; // 00 in BCD
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b0101_1001) begin // 59 in BCD
                ss <= 8'b0000_0000; // Reset seconds to 00
                // Increment minutes
                if (mm == 8'b0101_1001) begin // 59 in BCD
                    mm <= 8'b0000_0000; // Reset minutes to 00
                    // Increment hours
                    if (hh == 8'b0001_0010) begin // 12 in BCD
                        hh <= 8'b0000_0001; // Reset hours to 01
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'b0000_1001) begin // 09 in BCD
                        hh <= 8'b0001_0000; // Increment to 10
                    end else if (hh == 8'b0001_0000) begin // 10 in BCD
                        hh <= 8'b0001_0001; // Increment to 11
                    end else if (hh == 8'b0001_0001) begin // 11 in BCD
                        hh <= 8'b0001_0010; // Increment to 12
                    end else begin
                        hh <= hh + 8'b0000_0001; // Increment hours
                    end
                end else if (mm[3:0] == 4'b1001) begin // 9 in BCD
                    mm <= {mm[7:4] + 4'b0001, 4'b0000}; // Increment tens place
                end else begin
                    mm <= mm + 8'b0000_0001; // Increment minutes
                end
            end else if (ss[3:0] == 4'b1001) begin // 9 in BCD
                ss <= {ss[7:4] + 4'b0001, 4'b0000}; // Increment tens place
            end else begin
                ss <= ss + 8'b0000_0001; // Increment seconds
            end
        end
    end

endmodule