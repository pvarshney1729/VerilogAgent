module TopModule(
    input  logic clk,           // Clock signal (fast-running)
    input  logic reset,         // Active-high synchronous reset
    input  logic ena,           // Enable signal for time increment (one pulse per second)
    output logic pm,            // AM/PM indicator (1 for PM, 0 for AM)
    output logic [7:0] hh,      // Hours in BCD (01 to 12)
    output logic [7:0] mm,      // Minutes in BCD (00 to 59)
    output logic [7:0] ss       // Seconds in BCD (00 to 59)
);

    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00:00 AM
            hh <= 8'b0001_0010; // 12 in BCD
            mm <= 8'b0000_0000; // 00 in BCD
            ss <= 8'b0000_0000; // 00 in BCD
            pm <= 1'b0;         // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b0101_1001) begin
                ss <= 8'b0000_0000;
                // Increment minutes
                if (mm == 8'b0101_1001) begin
                    mm <= 8'b0000_0000;
                    // Increment hours
                    if (hh == 8'b0001_0010) begin
                        hh <= 8'b0000_0001;
                        // Toggle AM/PM
                        pm <= ~pm;
                    end else if (hh == 8'b0000_1001) begin
                        hh <= 8'b0001_0000;
                    end else if (hh == 8'b0001_0000) begin
                        hh <= 8'b0001_0001;
                    end else if (hh == 8'b0001_0001) begin
                        hh <= 8'b0001_0010;
                    end else begin
                        hh <= hh + 1;
                    end
                end else begin
                    mm <= mm + 1;
                end
            end else begin
                ss <= ss + 1;
            end
        end
    end

endmodule