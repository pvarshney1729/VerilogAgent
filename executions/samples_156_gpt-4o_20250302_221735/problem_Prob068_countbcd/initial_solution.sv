module TopModule (
    input logic clk,          // Clock input, positive edge-triggered
    input logic reset,        // Synchronous active-high reset
    output logic [2:0] ena,   // Enable signals for BCD digit increment
    output logic [15:0] q     // BCD counter output (4 digits)
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 16'd0;
            ena <= 3'b000;
        end else begin
            // Increment ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                ena[0] <= 1'b1;
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
                ena[0] <= 1'b0;
            end

            // Increment tens digit if ena[0] is asserted
            if (ena[0]) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    ena[1] <= 1'b1;
                end else begin
                    q[7:4] <= q[7:4] + 4'd1;
                    ena[1] <= 1'b0;
                end
            end else begin
                ena[1] <= 1'b0;
            end

            // Increment hundreds digit if ena[1] is asserted
            if (ena[1]) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                    ena[2] <= 1'b1;
                end else begin
                    q[11:8] <= q[11:8] + 4'd1;
                    ena[2] <= 1'b0;
                end
            end else begin
                ena[2] <= 1'b0;
            end

            // Increment thousands digit if ena[2] is asserted
            if (ena[2]) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end else begin
                    q[15:12] <= q[15:12] + 4'd1;
                end
            end
        end
    end

endmodule