module TopModule(
    input logic clk,        // Clock signal, much faster than `ena`.
    input logic reset,      // Synchronous active-high reset signal.
    input logic ena,        // Enable signal for incrementing the clock.
    output logic pm,        // 1-bit output, asserted for PM, de-asserted for AM.
    output logic [7:0] hh,  // 8-bit output for hours (BCD format, 01-12).
    output logic [7:0] mm,  // 8-bit output for minutes (BCD format, 00-59).
    output logic [7:0] ss   // 8-bit output for seconds (BCD format, 00-59).
);

    // Initialize registers
    initial begin
        hh = 8'b00000000;
        mm = 8'b00000000;
        ss = 8'b00000000;
        pm = 0;
    end

    // Clock behavior
    always_ff @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010; // 12 in BCD
            mm <= 8'b00000000; // 00 in BCD
            ss <= 8'b00000000; // 00 in BCD
            pm <= 0;           // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b01011000) begin
                ss <= 8'b00000000;
                // Increment minutes
                if (mm == 8'b01011000) begin
                    mm <= 8'b00000000;
                    // Increment hours
                    if (hh == 8'b00010010) begin
                        hh <= 8'b00000001;
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'b00010001) begin
                        hh <= 8'b00010010; // 12 in BCD
                    end else begin
                        hh <= hh + 8'b00000001;
                    end
                end else begin
                    mm <= mm + 8'b00000001;
                end
            end else begin
                ss <= ss + 8'b00000001;
            end
        end
    end

endmodule