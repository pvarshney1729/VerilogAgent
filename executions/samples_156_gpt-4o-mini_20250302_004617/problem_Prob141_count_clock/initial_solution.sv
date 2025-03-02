module TopModule (
    input logic clk,
    input logic reset,
    output logic [4:0] hours,
    output logic [5:0] minutes,
    output logic [5:0] seconds
);

    // State registers
    logic [4:0] hours_reg;
    logic [5:0] minutes_reg;
    logic [5:0] seconds_reg;

    // Synchronous reset and increment logic
    always @(*) begin
        if (reset) begin
            hours_reg = 5'b00000;
            minutes_reg = 6'b000000;
            seconds_reg = 6'b000000;
        end else begin
            if (seconds_reg == 6'b111011) begin // 59 seconds
                seconds_reg = 6'b000000;
                if (minutes_reg == 6'b111011) begin // 59 minutes
                    minutes_reg = 6'b000000;
                    if (hours_reg == 5'b10100) begin // 24 hours
                        hours_reg = 5'b00000; // Reset to 0
                    end else begin
                        hours_reg = hours_reg + 5'b00001;
                    end
                end else begin
                    minutes_reg = minutes_reg + 6'b000001;
                end
            end else begin
                seconds_reg = seconds_reg + 6'b000001;
            end
        end
    end

    // Assign outputs
    assign hours = hours_reg;
    assign minutes = minutes_reg;
    assign seconds = seconds_reg;

endmodule