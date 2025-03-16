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
            // Reset condition
            hh <= 8'b00010010; // BCD for 12
            mm <= 8'b00000000; // BCD for 00
            ss <= 8'b00000000; // BCD for 00
            pm <= 1'b0;        // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b01011001) begin // BCD for 59
                ss <= 8'b00000000; // Reset seconds to 00
                if (mm == 8'b01011001) begin // BCD for 59
                    mm <= 8'b00000000; // Reset minutes to 00
                    if (hh == 8'b00010010) begin // BCD for 12
                        hh <= 8'b00000001; // Reset hours to 01
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'b00001001) begin // BCD for 09
                        hh <= 8'b00010000; // Set hours to 10
                    end else begin
                        hh <= hh + 1; // Increment hours
                    end
                end else if (mm[3:0] == 4'b1001) begin // BCD tens digit 9
                    mm <= {mm[7:4] + 1'b1, 4'b0000}; // Increment tens digit
                end else begin
                    mm <= mm + 1; // Increment minutes
                end
            end else if (ss[3:0] == 4'b1001) begin // BCD tens digit 9
                ss <= {ss[7:4] + 1'b1, 4'b0000}; // Increment tens digit
            end else begin
                ss <= ss + 1; // Increment seconds
            end
        end
    end

endmodule