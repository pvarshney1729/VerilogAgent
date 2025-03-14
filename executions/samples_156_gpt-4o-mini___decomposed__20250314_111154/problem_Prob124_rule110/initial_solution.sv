module TopModule (
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    reg [511:0] q_next;

    always @(*) begin
        q_next[0] = (q[0] & q[1]) | (q[1] & 1'b0) | (~q[0] & q[1]);
        for (integer i = 1; i < 511; i = i + 1) begin
            q_next[i] = (q[i-1] & q[i]) | (q[i] & ~q[i+1]) | (~q[i-1] & q[i]);
        end
        q_next[511] = (q[510] & q[511]) | (q[511] & 1'b0) | (~q[510] & q[511]);
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly