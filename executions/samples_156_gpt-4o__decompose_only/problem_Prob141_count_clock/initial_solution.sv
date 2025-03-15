module TopModule (
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    // Internal signals for carry between counters
    logic carry_out_ss;
    logic carry_out_mm;

    // Seconds counter
    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'b0000_0000; // Reset seconds to 00
        end else if (ena) begin
            if (ss == 8'b0101_1001) begin // Check if seconds are 59
                ss <= 8'b0000_0000; // Reset to 00
            end else begin
                ss <= ss + 1; // Increment seconds
            end
        end
    end

    assign carry_out_ss = (ss == 8'b0101_1001) && ena; // Carry out when seconds reset from 59 to 00

    // Minutes counter
    always @(posedge clk) begin
        if (reset) begin
            mm <= 8'b0000_0000; // Reset minutes to 00
        end else if (carry_out_ss) begin
            if (mm == 8'b0101_1001) begin // Check if minutes are 59
                mm <= 8'b0000_0000; // Reset to 00
            end else begin
                if (mm[3:0] == 4'b1001) begin // Check if lower BCD digit is 9
                    mm[3:0] <= 4'b0000; // Reset lower BCD digit
                    mm[7:4] <= mm[7:4] + 1; // Increment upper BCD digit
                end else begin
                    mm[3:0] <= mm[3:0] + 1; // Increment lower BCD digit
                end
            end
        end
    end

    assign carry_out_mm = (mm == 8'b0101_1001) && carry_out_ss; // Carry out when minutes reset from 59 to 00

    // Hours counter
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b0001_0010; // Reset hours to 12
            pm <= 1'b0;         // Reset to AM
        end else if (carry_out_mm) begin
            if (hh == 8'b0001_0010) begin // Check if hours are 12
                hh <= 8'b0000_0001; // Reset to 01
                pm <= ~pm;          // Toggle PM
            end else begin
                if (hh[3:0] == 4'b1001) begin // If lower BCD digit is 9
                    hh[3:0] <= 4'b0000;       // Reset lower BCD digit
                    hh[7:4] <= hh[7:4] + 1;   // Increment upper BCD digit
                end else begin
                    hh[3:0] <= hh[3:0] + 1;   // Increment lower BCD digit
                end
            end
        end
    end

endmodule