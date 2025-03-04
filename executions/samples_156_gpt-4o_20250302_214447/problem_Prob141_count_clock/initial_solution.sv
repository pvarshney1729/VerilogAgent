module TopModule (
    input logic clk,               // Clock input, assumed to be much faster than ena
    input logic reset,             // Active high synchronous reset signal
    input logic ena,               // Enable signal, pulses once per second
    output logic pm,               // PM indicator, 1 for PM, 0 for AM
    output logic [7:0] hh,         // Hours in BCD format, range 01 to 12
    output logic [7:0] mm,         // Minutes in BCD format, range 00 to 59
    output logic [7:0] ss          // Seconds in BCD format, range 00 to 59
);

    // Initial block for simulation purposes
    initial begin
        pm = 0;
        hh = 8'b0001_0010; // 12 in BCD
        mm = 8'b0000_0000; // 00 in BCD
        ss = 8'b0000_0000; // 00 in BCD
    end

    // Sequential logic for clock operation
    always_ff @(posedge clk) begin
        if (reset) begin
            pm <= 0;
            hh <= 8'b0001_0010; // 12 in BCD
            mm <= 8'b0000_0000; // 00 in BCD
            ss <= 8'b0000_0000; // 00 in BCD
        end else if (ena) begin
            if (ss == 8'b0101_1001) begin // 59 in BCD
                ss <= 8'b0000_0000; // Reset seconds to 00
                if (mm == 8'b0101_1001) begin // 59 in BCD
                    mm <= 8'b0000_0000; // Reset minutes to 00
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
                        hh <= hh + 1; // Increment hours
                    end
                end else begin
                    mm <= mm + 1; // Increment minutes
                end
            end else begin
                ss <= ss + 1; // Increment seconds
            end
        end
    end

endmodule