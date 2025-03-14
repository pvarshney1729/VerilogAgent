module TopModule(
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

    always @(posedge clk) begin
        if (reset) begin
            // Reset all counters to "12:00:00 AM"
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

    // Concatenate BCD digits to form the output
    always @(*) begin
        hh = {hh_tens, hh_units};
        mm = {mm_tens, mm_units};
        ss = {ss_tens, ss_units};
    end

endmodule