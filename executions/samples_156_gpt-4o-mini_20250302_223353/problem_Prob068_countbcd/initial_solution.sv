module TopModule (
    input  logic clk,
    input  logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0000_0000_0000_0000;
            ena <= 3'b000;
        end else begin
            ena <= 3'b000; // Reset enable signals
            if (q[3:0] == 4'b1001) begin
                q[3:0] <= 4'b0000; // Reset ones
                ena[0] <= 1'b1; // Enable next digit
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0000; // Reset tens
                    ena[1] <= 1'b1; // Enable next digit
                    if (q[11:8] == 4'b1001) begin
                        q[11:8] <= 4'b0000; // Reset hundreds
                        ena[2] <= 1'b1; // Enable next digit
                        if (q[15:12] == 4'b1001) begin
                            q[15:12] <= 4'b0000; // Reset thousands
                        end else begin
                            q[15:12] <= q[15:12] + 1'b1; // Increment thousands
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 1'b1; // Increment hundreds
                    end
                end else begin
                    q[7:4] <= q[7:4] + 1'b1; // Increment tens
                end
            end else begin
                q[3:0] <= q[3:0] + 1'b1; // Increment ones
            end
        end
    end

endmodule