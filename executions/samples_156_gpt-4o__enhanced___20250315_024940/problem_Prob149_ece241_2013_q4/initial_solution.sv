module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    // State to hold previous sensor level
    logic [2:0] prev_s;

    // Always block for sequential logic (with synchronous reset)
    always @(posedge clk) begin
        if (reset) begin
            // Reset all outputs and previous state
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b0;
            prev_s <= 3'b000; // No sensors asserted
        end else begin
            // Update previous state to current state
            prev_s <= s;

            // Flow control logic based on sensor states
            if (s[2]) begin
                // Above s[2]
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                fr0 <= 1'b0;
                dfr <= 1'b0;
            end else if (s[1]) begin
                // Between s[2] and s[1]
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                fr0 <= 1'b1;
                dfr <= (prev_s[2] == 1'b0) ? 1'b1 : 1'b0; // Increase flow if previous was lower
            end else if (s[0]) begin
                // Between s[1] and s[0]
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                fr0 <= 1'b1;
                dfr <= (prev_s[1:0] == 2'b00) ? 1'b1 : 1'b0; // Increase flow if previous was lower
            end else begin
                // Below s[0]
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                fr0 <= 1'b1;
                dfr <= 1'b0;
            end
        end
    end

    // Assign outputs to logic values
    assign fr2 = fr2;
    assign fr1 = fr1;
    assign fr0 = fr0;
    assign dfr = dfr;

endmodule