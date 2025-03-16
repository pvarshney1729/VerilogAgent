module TopModule (
    input logic clk,
    input logic reset,
    input logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    logic [2:0] last_s;

    always @(posedge clk) begin
        if (reset) begin
            fr2 <= 1'b1; // All outputs to maximum flow (low water level)
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b0;
            last_s <= 3'b0; // No sensors asserted
        end else begin
            last_s <= s;
            case (s)
                3'b111: begin // Above s[2]
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b0;
                    dfr <= 1'b0;
                end
                3'b110: begin // Between s[2] and s[1]
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b1;
                    dfr <= (last_s < s) ? 1'b1 : 1'b0; // Supplemental flow valve control
                end
                3'b100: begin // Between s[1] and s[0]
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= (last_s < s) ? 1'b1 : 1'b0;
                end
                3'b000: begin // Below s[0]
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= 1'b0;
                end
                default: begin
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= 1'b0; // Default case for unhandled sensor states
                end
            endcase
        end
    end
endmodule