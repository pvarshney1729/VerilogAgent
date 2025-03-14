module TopModule(
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0;
            ena <= 3'b0;
        end else begin
            // Increment ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                ena[0] <= 1'b1;
            end else begin
                q[3:0] <= q[3:0] + 1;
                ena[0] <= 1'b0;
            end

            // Increment tens digit
            if (ena[0]) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    ena[1] <= 1'b1;
                end else begin
                    q[7:4] <= q[7:4] + 1;
                    ena[1] <= 1'b0;
                end
            end

            // Increment hundreds digit
            if (ena[1]) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                    ena[2] <= 1'b1;
                end else begin
                    q[11:8] <= q[11:8] + 1;
                    ena[2] <= 1'b0;
                end
            end

            // Increment thousands digit
            if (ena[2]) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end else begin
                    q[15:12] <= q[15:12] + 1;
                end
            end
        end
    end

endmodule