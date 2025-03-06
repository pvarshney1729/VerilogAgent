module TopModule(
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 16'b0;
            ena <= 3'b0;
        end else begin
            // Default enable signals to zero
            ena <= 3'b0;
            
            // Increment the ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                // Increment the tens digit
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    ena[0] <= 1'b1; // Assert enable for tens digit
                    // Increment the hundreds digit
                    if (q[11:8] == 4'd9) begin
                        q[11:8] <= 4'd0;
                        ena[1] <= 1'b1; // Assert enable for hundreds digit
                        // Increment the thousands digit
                        if (q[15:12] == 4'd9) begin
                            q[15:12] <= 4'd0;
                            ena[2] <= 1'b1; // Assert enable for thousands digit
                        end else begin
                            q[15:12] <= q[15:12] + 4'd1;
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 4'd1;
                    end
                end else begin
                    q[7:4] <= q[7:4] + 4'd1;
                end
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
            end
        end
    end

endmodule