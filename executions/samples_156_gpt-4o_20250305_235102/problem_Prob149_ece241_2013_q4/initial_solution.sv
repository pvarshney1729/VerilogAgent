module TopModule (
    input  logic        clk,      // Clock signal
    input  logic        reset,    // Active-high synchronous reset
    input  logic [2:0]  s,        // 3-bit water level sensor input, s[2] is MSB
    output logic        fr2,      // Output control for flow rate level 2
    output logic        fr1,      // Output control for flow rate level 1
    output logic        fr0,      // Output control for flow rate level 0
    output logic        dfr       // Output control for supplemental flow rate
);

    logic [2:0] prev_s; // Previous state of sensor input

    always_ff @(posedge clk) begin
        if (reset) begin
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b1;
            prev_s <= 3'b000;
        end else begin
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
                    dfr <= (prev_s != 3'b000);
                end
                default: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b0;
                    dfr <= 1'b0;
                end
            endcase
            prev_s <= s;
        end
    end

endmodule