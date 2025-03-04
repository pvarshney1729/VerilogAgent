```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'h0000;
        end else begin
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    if (q[11:8] == 4'd9) begin
                        q[11:8] <= 4'd0;
                        if (q[15:12] == 4'd9) begin
                            q[15:12] <= 4'd0; // wrap around to 0
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

    always @(*) begin
        ena[0] = (q[3:0] == 4'd0) && (q[3:0] != 4'd9);
        ena[1] = (q[7:4] == 4'd0) && (q[7:4] != 4'd9);
        ena[2] = (q[11:8] == 4'd0) && (q[11:8] != 4'd9);
    end

endmodule
```