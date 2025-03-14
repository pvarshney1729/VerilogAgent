module TopModule (
    input  logic clk,         // Clock signal (1 bit)
    input  logic reset,       // Active-high synchronous reset (1 bit)
    input  logic [2:0] s,     // Water level sensors (3 bits): s[2] (highest), s[1], s[0] (lowest)
    output logic fr2,         // Flow rate control signal 2 (1 bit)
    output logic fr1,         // Flow rate control signal 1 (1 bit)
    output logic fr0,         // Flow rate control signal 0 (1 bit)
    output logic dfr          // Supplemental flow valve control (1 bit)
);

    logic [2:0] previous_level;

    always @(posedge clk) begin
        if (reset) begin
            fr0 <= 1;
            fr1 <= 1;
            fr2 <= 1;
            dfr <= 0;
            previous_level <= 3'b000; // Initial state below lowest sensor
        end else begin
            previous_level <= s; // Update previous level
            case (s)
                3'b111: begin // Above s[2]
                    fr0 <= 0; 
                    fr1 <= 0; 
                    fr2 <= 0; 
                    dfr <= 0;
                end
                3'b110: begin // Between s[2] and s[1]
                    fr0 <= 1; 
                    fr1 <= 0; 
                    fr2 <= 0; 
                    dfr <= 0;
                end
                3'b100: begin // Between s[1] and s[0]
                    fr0 <= 1; 
                    fr1 <= 1; 
                    fr2 <= 0; 
                    dfr <= 0;
                end
                3'b000: begin // Below s[0]
                    fr0 <= 1; 
                    fr1 <= 1; 
                    fr2 <= 1; 
                    dfr <= 1; // Open supplemental flow valve
                end
                default: begin
                    fr0 <= 0;
                    fr1 <= 0;
                    fr2 <= 0;
                    dfr <= 0;
                end
            endcase
        end
    end
endmodule