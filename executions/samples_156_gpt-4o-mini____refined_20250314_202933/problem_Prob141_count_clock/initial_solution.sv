[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);

    logic [3:0] sec_tens, sec_units;
    logic [3:0] min_tens, min_units;
    logic [3:0] hour_tens, hour_units;
    logic pm_flag;

    always @(posedge clk) begin
        if (reset) begin
            sec_tens <= 4'b0000;
            sec_units <= 4'b0000;
            min_tens <= 4'b0000;
            min_units <= 4'b0000;
            hour_tens <= 4'b0000;
            hour_units <= 4'b0001; // Start at 1 for 12-hour format
            pm_flag <= 1'b0;
        end else if (ena) begin
            if (sec_units == 4'b1001) begin
                sec_units <= 4'b0000;
                if (sec_tens == 4'b0101) begin
                    sec_tens <= 4'b0000;
                    if (min_units == 4'b1001) begin
                        min_units <= 4'b0000;
                        if (min_tens == 4'b0101) begin
                            min_tens <= 4'b0000;
                            if (hour_units == 4'b0010 && hour_tens == 4'b0001) begin
                                hour_units <= 4'b0001; // Reset to 1
                                hour_tens <= 4'b0000; // Reset hour tens
                                pm_flag <= ~pm_flag; // Toggle PM/AM
                            end else if (hour_units == 4'b1001) begin
                                hour_units <= 4'b0000;
                                hour_tens <= hour_tens + 4'b0001; // Increment hour tens
                            end else begin
                                hour_units <= hour_units + 4'b0001; // Increment hour units
                            end
                        end else begin
                            min_units <= min_units + 4'b0001; // Increment minute units
                        end
                    end else begin
                        sec_units <= sec_units + 4'b0001; // Increment second units
                    end
                end else begin
                    sec_units <= sec_units + 4'b0001; // Increment second units
                end
            end
        end
    end

    always @(*) begin
        hh = {hour_tens, hour_units};
        mm = {min_tens, min_units};
        ss = {sec_tens, sec_units};
        pm = pm_flag;
    end

endmodule
[DONE]