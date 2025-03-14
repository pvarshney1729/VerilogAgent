module TopModule (
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] next_q;

    always @(*) begin
        integer i;
        for (i = 0; i < 512; i = i + 1) begin
            if (i == 0) begin
                // Left boundary: q[-1] is assumed to be 0
                next_q[i] = (1'b0 & q[i] & q[i+1]) | (1'b0 & q[i] & ~q[i+1]) | (1'b0 & ~q[i] & q[i+1]) | (~1'b0 & q[i] & q[i+1]);
            end else if (i == 511) begin
                // Right boundary: q[512] is assumed to be 0
                next_q[i] = (q[i-1] & q[i] & 1'b0) | (q[i-1] & ~q[i] & 1'b0) | (~q[i-1] & q[i] & 1'b0) | (~q[i-1] & q[i] & ~1'b0);
            end else begin
                // General case for cell i
                next_q[i] = (q[i-1] & q[i] & q[i+1]) | (q[i-1] & q[i] & ~q[i+1]) | (q[i-1] & ~q[i] & q[i+1]) | (~q[i-1] & q[i] & q[i+1]);
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule