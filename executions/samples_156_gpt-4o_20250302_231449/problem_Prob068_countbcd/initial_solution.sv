module TopModule (
    input logic clk,        // 1-bit clock signal
    input logic reset,      // 1-bit synchronous active-high reset signal
    output logic [2:0] ena, // 3-bit enable signal for upper three BCD digits
    output logic [15:0] q   // 16-bit BCD counter output
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 16'h0000;
        end else begin
            // Increment the ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                ena[0] <= 1'b1;
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
                ena[0] <= 1'b0;
            end

            // Increment the tens digit
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

            // Increment the hundreds digit
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

            // Increment the thousands digit
            if (ena[2]) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end else begin
                    q[15:12] <= q[15:12] + 4'd1;
                end
            end

            // Handle overflow beyond 9999
            if (q == 16'h9999) begin
                q <= 16'h0000;
            end
        end
    end

endmodule