module TopModule (
    input logic clk,
    input logic reset,
    input logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    logic [1:0] prev_level;

    always @(posedge clk) begin
        if (reset) begin
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b1;
            prev_level <= 2'b00; // Reset to low level state
        end else begin
            case(s)
                3'b111: begin // Above s[2]
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b0;
                    dfr <= 1'b0; // No flow
                    prev_level <= 2'b11; // Update prev level to above s[2]
                end
                3'b110: begin // Between s[2] and s[1]
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b1; // Nominal flow fr0
                    dfr <= (prev_level == 2'b10) ? 1'b1 : 1'b0; // Increase flow if level went up
                    prev_level <= 2'b10; // Update prev level
                end
                3'b100: begin // Between s[1] and s[0]
                    fr2 <= 1'b0;
                    fr1 <= 1'b1; // Nominal flow fr1
                    fr0 <= 1'b1; // Nominal flow fr0
                    dfr <= (prev_level == 2'b01) ? 1'b1 : 1'b0; // Increase flow if level went up
                    prev_level <= 2'b01; // Update prev level
                end
                default: begin // Below s[0] (none asserted)
                    fr2 <= 1'b1; // Maximum flow
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= 1'b1; // Open all valves
                    prev_level <= 2'b00; // Update prev level to below s[0]
                end
            endcase
        end
    end

endmodule