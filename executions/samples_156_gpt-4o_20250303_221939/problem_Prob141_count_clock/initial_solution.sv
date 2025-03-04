module digital_clock(
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    // BCD constants
    localparam BCD_ZERO = 8'b0000_0000;
    localparam BCD_ONE = 8'b0000_0001;
    localparam BCD_TWELVE = 8'b0001_0010;
    localparam BCD_SIXTY = 8'b0110_0000;

    always_ff @(posedge clk) begin
        if (reset) begin
            hh <= BCD_TWELVE;
            mm <= BCD_ZERO;
            ss <= BCD_ZERO;
            pm <= 1'b0;
        end else if (ena) begin
            // Increment seconds
            if (ss == BCD_SIXTY - 1) begin
                ss <= BCD_ZERO;
                // Increment minutes
                if (mm == BCD_SIXTY - 1) begin
                    mm <= BCD_ZERO;
                    // Increment hours
                    if (hh == BCD_TWELVE) begin
                        hh <= BCD_ONE;
                        pm <= ~pm; // Toggle PM/AM
                    end else begin
                        hh <= hh + BCD_ONE;
                    end
                end else begin
                    mm <= mm + BCD_ONE;
                end
            end else begin
                ss <= ss + BCD_ONE;
            end
        end
    end

endmodule