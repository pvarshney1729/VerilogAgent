module TopModule (
    input logic clk,               // Fast-running clock signal
    input logic reset,             // Active high synchronous reset
    input logic ena,               // Enable signal for incrementing time
    output logic pm,                // PM indicator, 1 for PM, 0 for AM
    output logic [7:0] hh,          // Hours in BCD, range: 01 to 12
    output logic [7:0] mm,          // Minutes in BCD, range: 00 to 59
    output logic [7:0] ss           // Seconds in BCD, range: 00 to 59
);

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b0001_0010; // 12 in BCD
            mm <= 8'b0000_0000; // 00 in BCD
            ss <= 8'b0000_0000; // 00 in BCD
            pm <= 1'b0;         // AM
        end else if (ena) begin
            if (ss == 8'b0000_0100_1111) begin // 59 in BCD
                ss <= 8'b0000_0000; // Reset seconds to 00
                if (mm == 8'b0000_0100_1111) begin // 59 in BCD
                    mm <= 8'b0000_0000; // Reset minutes to 00
                    if (hh == 8'b0001_0010) begin // 12 in BCD
                        hh <= 8'b0000_0001; // Reset hours to 01
                        pm <= ~pm; // Toggle PM/AM
                    end else begin
                        hh <= hh + 8'b0000_0001; // Increment hours
                    end
                end else begin
                    mm <= mm + 8'b0000_0001; // Increment minutes
                end
            end else begin
                ss <= ss + 8'b0000_0001; // Increment seconds
            end
        end
    end

    initial begin
        hh = 8'b0001_0010; // 12 in BCD
        mm = 8'b0000_0000; // 00 in BCD
        ss = 8'b0000_0000; // 00 in BCD
        pm = 1'b0;         // AM
    end

endmodule