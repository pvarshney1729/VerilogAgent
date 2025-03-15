module TopModule (
    input clk,
    input reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0;
            ena <= 3'b0;
        end else begin
            ena <= 3'b0; // Reset enable signals
            if (q[3:0] == 4'b1001) begin
                q[3:0] <= 4'b0000;
                ena[0] <= 1'b1; // Enable for tens
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0000;
                    ena[1] <= 1'b1; // Enable for hundreds
                    if (q[11:8] == 4'b1001) begin
                        q[11:8] <= 4'b0000;
                        ena[2] <= 1'b1; // Enable for thousands
                        if (q[15:12] == 4'b1001) begin
                            q[15:12] <= 4'b0000; // Reset thousands
                        end else begin
                            q[15:12] <= q[15:12] + 1;
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 1;
                    end
                end else begin
                    q[7:4] <= q[7:4] + 1;
                end
            end else begin
                q[3:0] <= q[3:0] + 1;
            end
        end
    end
endmodule