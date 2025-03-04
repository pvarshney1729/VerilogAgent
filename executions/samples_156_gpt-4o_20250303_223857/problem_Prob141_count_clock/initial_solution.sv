module TopModule (
    input logic clk,         // System clock input
    input logic reset,       // Active high synchronous reset
    input logic ena,         // Enable pulse input, active high
    output logic pm,         // AM/PM indicator, 1 for PM, 0 for AM
    output logic [7:0] hh,   // Hours in BCD (01-12)
    output logic [7:0] mm,   // Minutes in BCD (00-59)
    output logic [7:0] ss    // Seconds in BCD (00-59)
);

    // Internal registers for timekeeping
    logic [3:0] hh_ones, hh_tens;
    logic [3:0] mm_ones, mm_tens;
    logic [3:0] ss_ones, ss_tens;

    // Initialize the clock to 12:00:00 AM
    initial begin
        pm = 1'b0;
        hh = 8'h12; // 12 in BCD
        mm = 8'h00; // 00 in BCD
        ss = 8'h00; // 00 in BCD
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00:00 AM
            pm <= 1'b0;
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;
                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    // Increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end else begin
                        hh_ones = hh[3:0];
                        hh_tens = hh[7:4];
                        if (hh_ones == 4'h9) begin
                            hh_ones <= 4'h0;
                            hh_tens <= hh_tens + 1;
                        end else begin
                            hh_ones <= hh_ones + 1;
                        end
                        hh <= {hh_tens, hh_ones};
                    end
                end else begin
                    mm_ones = mm[3:0];
                    mm_tens = mm[7:4];
                    if (mm_ones == 4'h9) begin
                        mm_ones <= 4'h0;
                        mm_tens <= mm_tens + 1;
                    end else begin
                        mm_ones <= mm_ones + 1;
                    end
                    mm <= {mm_tens, mm_ones};
                end
            end else begin
                ss_ones = ss[3:0];
                ss_tens = ss[7:4];
                if (ss_ones == 4'h9) begin
                    ss_ones <= 4'h0;
                    ss_tens <= ss_tens + 1;
                end else begin
                    ss_ones <= ss_ones + 1;
                end
                ss <= {ss_tens, ss_ones};
            end
        end
    end

endmodule