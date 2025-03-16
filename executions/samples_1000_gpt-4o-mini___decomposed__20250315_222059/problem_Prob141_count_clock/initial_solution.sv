module TopModule (
    input logic clk,
    input logic reset,
    input logic ena,
    output logic pm,
    output logic [7:0] hh,
    output logic [7:0] mm,
    output logic [7:0] ss
);
    
    reg [3:0] sec_cnt;
    reg [3:0] min_cnt;
    reg [3:0] hour_ones;
    reg [3:0] hour_tens;

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00001100; // Reset to 12
            mm <= 8'b00000000; // Reset to 00
            ss <= 8'b00000000; // Reset to 00
            pm <= 0; // Reset to AM
            sec_cnt <= 0;
            min_cnt <= 0;
            hour_ones <= 0;
            hour_tens <= 0;
        end else if (ena) begin
            if (sec_cnt == 4'd9) begin
                sec_cnt <= 0;
                if (ss == 8'd59) begin
                    ss <= 0;
                    if (min_cnt == 4'd9) begin
                        min_cnt <= 0;
                        if (hour_ones == 4'b1001) begin // If hours are 09
                            hour_ones <= 0; // Reset ones to 0
                            if (hour_tens == 4'b0001) begin // If tens are 1 (10-12)
                                hour_tens <= 0; // Reset tens to 0
                                pm <= ~pm; // Toggle PM/AM
                            end else begin
                                hour_tens <= hour_tens + 1; // Increment tens
                            end
                        end else begin
                            hour_ones <= hour_ones + 1; // Increment ones
                        end
                    end else begin
                        min_cnt <= min_cnt + 1; // Increment minutes
                    end
                end else begin
                    ss <= ss + 1; // Increment seconds
                end
            end else begin
                sec_cnt <= sec_cnt + 1; // Increment seconds counter
            end
        end
    end

    assign hh = {hour_tens, hour_ones}; // Assign BCD hours output
    assign mm = {4'b0000, min_cnt}; // Assign BCD minutes output
    assign ss = {4'b0000, sec_cnt}; // Assign BCD seconds output

endmodule