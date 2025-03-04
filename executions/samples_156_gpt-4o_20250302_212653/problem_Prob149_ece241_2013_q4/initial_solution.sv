module TopModule (
    input  logic clk,                // Clock signal
    input  logic reset,              // Active-high synchronous reset
    input  logic [2:0] s,            // 3-bit input from sensors, s[2] is the highest sensor
    output logic fr2,                // Output for Nominal Flow Rate fr2
    output logic fr1,                // Output for Nominal Flow Rate fr1
    output logic fr0,                // Output for Nominal Flow Rate fr0
    output logic dfr                 // Output for Supplemental Flow Rate decision
);

    // State variable to track the previous water level
    logic prev_level;

    // Sequential logic for state management and output control
    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset state
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b1;
            prev_level <= 1'b0;
        end else begin
            // Logic based on sensor input
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
                    dfr <= prev_level;
                end
                3'b001: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= prev_level;
                end
                3'b000: begin
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= 1'b0;
                end
                default: begin
                    // Default case to handle unexpected states
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= 1'b0;
                end
            endcase
            // Update previous level state
            prev_level <= (s == 3'b111 || s == 3'b011);
        end
    end

endmodule