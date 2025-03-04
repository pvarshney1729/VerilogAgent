module TopModule (
    input logic clk,           // Clock signal for synchronous logic
    input logic reset,         // Active-high synchronous reset
    input logic [2:0] s,       // 3-bit input for water level sensors
    output logic fr2,          // Flow rate control output
    output logic fr1,          // Flow rate control output
    output logic fr0,          // Flow rate control output
    output logic dfr           // Supplemental flow valve control output
);

    logic [2:0] prev_s;        // Register to store the previous state of s

    always_ff @(posedge clk) begin
        if (reset) begin
            // On reset, initialize to the state as if water level is below the lowest sensor
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b1;
            prev_s <= 3'b000;
        end else begin
            // Determine flow rate control outputs based on current sensor input
            case (s)
                3'b111: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b0;
                    dfr <= 1'b0;
                end
                3'b011: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b1;
                    dfr <= 1'b0;
                end
                3'b001: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= 1'b0;
                end
                3'b000: begin
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= 1'b1;
                end
                default: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b0;
                    dfr <= 1'b0;
                end
            endcase

            // Determine supplemental flow valve control based on change in water level
            if (s > prev_s) begin
                dfr <= 1'b1;
            end

            // Update previous sensor state
            prev_s <= s;
        end
    end

endmodule