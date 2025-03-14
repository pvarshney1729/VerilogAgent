[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

always @(posedge clk) begin
    if (reset) begin
        // Reset the clock to "12:00:00 AM"
        hh <= 8'b0001_0010; // BCD for 12
        mm <= 8'b0000_0000; // BCD for 00
        ss <= 8'b0000_0000; // BCD for 00
        pm <= 1'b0;         // AM
    end else if (ena) begin
        // Increment seconds
        if (ss == 8'b0101_1001) begin // BCD for 59
            ss <= 8'b0000_0000; // Reset seconds to 00
            // Increment minutes
            if (mm == 8'b0101_1001) begin // BCD for 59
                mm <= 8'b0000_0000; // Reset minutes to 00
                // Increment hours
                if (hh == 8'b0001_0010) begin // BCD for 12
                    hh <= 8'b0000_0001; // Reset hours to 01
                    pm <= ~pm;         // Toggle AM/PM
                end else if (hh == 8'b0001_0001) begin // BCD for 11
                    hh <= 8'b0001_0010; // Increment to 12
                end else begin
                    if (hh[3:0] == 4'b1001) begin
                        hh[3:0] <= 4'b0000;
                        hh[7:4] <= hh[7:4] + 1'b1;
                    end else begin
                        hh[3:0] <= hh[3:0] + 1'b1;
                    end
                end
            end else begin
                if (mm[3:0] == 4'b1001) begin
                    mm[3:0] <= 4'b0000;
                    mm[7:4] <= mm[7:4] + 1'b1;
                end else begin
                    mm[3:0] <= mm[3:0] + 1'b1;
                end
            end
        end else begin
            if (ss[3:0] == 4'b1001) begin
                ss[3:0] <= 4'b0000;
                ss[7:4] <= ss[7:4] + 1'b1;
            end else begin
                ss[3:0] <= ss[3:0] + 1'b1;
            end
        end
    end
end

endmodule
[DONE]