module TopModule (
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 16'b0000_0000_0000_0000;
            ena <= 3'b000;
        end else begin
            // Increment the ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                // Increment the tens digit
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    // Increment the hundreds digit
                    if (q[11:8] == 4'd9) begin
                        q[11:8] <= 4'd0;
                        // Increment the thousands digit
                        if (q[15:12] == 4'd9) begin
                            q[15:12] <= 4'd0;
                        end else begin
                            q[15:12] <= q[15:12] + 4'd1;
                        end
                        ena[2] <= 1'b1;
                    end else begin
                        q[11:8] <= q[11:8] + 4'd1;
                        ena[2] <= 1'b0;
                    end
                    ena[1] <= 1'b1;
                end else begin
                    q[7:4] <= q[7:4] + 4'd1;
                    ena[1] <= 1'b0;
                end
                ena[0] <= 1'b1;
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
                ena <= 3'b000;
            end
        end
    end

endmodule