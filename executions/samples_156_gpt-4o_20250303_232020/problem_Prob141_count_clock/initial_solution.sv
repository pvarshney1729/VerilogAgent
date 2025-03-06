module digital_clock (
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    // Internal registers for BCD counters
    logic [3:0] hh_tens, hh_units;
    logic [3:0] mm_tens, mm_units;
    logic [3:0] ss_tens, ss_units;

    // Combinational logic to convert BCD to 8-bit output
    assign hh = {hh_tens, hh_units};
    assign mm = {mm_tens, mm_units};
    assign ss = {ss_tens, ss_units};

    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset to initial state
            hh_tens <= 4'b0001; // 12 in BCD tens
            hh_units <= 4'b0010; // 12 in BCD units
            mm_tens <= 4'b0000;
            mm_units <= 4'b0000;
            ss_tens <= 4'b0000;
            ss_units <= 4'b0000;
            pm <= 1'b0;
        end else if (ena) begin
            // Increment seconds
            if (ss_units == 4'b1001) begin
                ss_units <= 4'b0000;
                if (ss_tens == 4'b0101) begin
                    ss_tens <= 4'b0000;
                    // Increment minutes
                    if (mm_units == 4'b1001) begin
                        mm_units <= 4'b0000;
                        if (mm_tens == 4'b0101) begin
                            mm_tens <= 4'b0000;
                            // Increment hours
                            if (hh_units == 4'b1001 || (hh_tens == 4'b0001 && hh_units == 4'b0010)) begin
                                hh_units <= 4'b0001;
                                hh_tens <= (hh_tens == 4'b0001) ? 4'b0000 : hh_tens;
                                pm <= ~pm; // Toggle AM/PM
                            end else begin
                                hh_units <= hh_units + 1;
                            end
                        end else begin
                            mm_tens <= mm_tens + 1;
                        end
                    end else begin
                        mm_units <= mm_units + 1;
                    end
                end else begin
                    ss_tens <= ss_tens + 1;
                end
            end else begin
                ss_units <= ss_units + 1;
            end
        end
    end

endmodule