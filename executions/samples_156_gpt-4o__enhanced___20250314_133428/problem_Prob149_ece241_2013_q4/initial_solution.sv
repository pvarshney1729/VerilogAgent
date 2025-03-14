module TopModule (
    input logic clk,             // Clock input
    input logic reset,           // Active-high synchronous reset
    input logic [2:0] s,         // Water level sensors (3 bits)
    output logic fr2,            // Flow rate control output
    output logic fr1,            // Flow rate control output
    output logic fr0,            // Flow rate control output
    output logic dfr             // Supplemental flow valve control
);

    // State to track previous sensor state
    logic [2:0] prev_s;

    always_ff @(posedge clk) begin
        if (reset) begin
            // On reset, assert all outputs
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b1;
            prev_s <= 3'b000;
        end else begin
            // Default de-assert all outputs
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            fr0 <= 1'b0;
            dfr <= 1'b0;

            // Determine flow rate based on sensor input
            case (s)
                3'b111: begin
                    // Above s[2], no flow
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b0;
                end
                3'b011: begin
                    // Between s[2] and s[1], nominal flow fr0
                    fr0 <= 1'b1;
                end
                3'b001: begin
                    // Between s[1] and s[0], nominal flow fr0, fr1
                    fr0 <= 1'b1;
                    fr1 <= 1'b1;
                end
                3'b000: begin
                    // Below s[0], maximum flow fr0, fr1, fr2
                    fr0 <= 1'b1;
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                end
            endcase

            // Determine if supplemental flow valve should be opened
            if (s > prev_s) begin
                dfr <= 1'b1;
            end

            // Update previous sensor state
            prev_s <= s;
        end
    end

endmodule