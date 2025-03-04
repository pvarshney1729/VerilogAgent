module TopModule (
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    // Internal registers for hours, minutes, and seconds
    logic [3:0] hh_tens, hh_units;
    logic [3:0] mm_tens, mm_units;
    logic [3:0] ss_tens, ss_units;

    // Assign outputs
    assign hh = {hh_tens, hh_units};
    assign mm = {mm_tens, mm_units};
    assign ss = {ss_tens, ss_units};

    // Sequential logic for counters
    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset all counters and PM flag
            hh_tens <= 4'd1;
            hh_units <= 4'd2;
            mm_tens <= 4'd0;
            mm_units <= 4'd0;
            ss_tens <= 4'd0;
            ss_units <= 4'd0;
            pm <= 1'b0;
        end else if (ena) begin
            // Increment seconds
            if (ss_units == 4'd9) begin
                ss_units <= 4'd0;
                if (ss_tens == 4'd5) begin
                    ss_tens <= 4'd0;
                    // Increment minutes
                    if (mm_units == 4'd9) begin
                        mm_units <= 4'd0;
                        if (mm_tens == 4'd5) begin
                            mm_tens <= 4'd0;
                            // Increment hours
                            if (hh_units == 4'd9 || (hh_tens == 4'd1 && hh_units == 4'd2)) begin
                                hh_units <= 4'd1;
                                hh_tens <= 4'd0;
                                pm <= ~pm; // Toggle AM/PM
                            end else if (hh_units == 4'd9) begin
                                hh_units <= 4'd0;
                                hh_tens <= hh_tens + 4'd1;
                            end else begin
                                hh_units <= hh_units + 4'd1;
                            end
                        end else begin
                            mm_tens <= mm_tens + 4'd1;
                        end
                    end else begin
                        mm_units <= mm_units + 4'd1;
                    end
                end else begin
                    ss_tens <= ss_tens + 4'd1;
                end
            end else begin
                ss_units <= ss_units + 4'd1;
            end
        end
    end

endmodule