module TopModule (
    input logic clk,
    input logic rst,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] q_next;

    always @(*) begin
        q_next[0] = (q[1] & q[0]) | (q[0] & 1'b0) | (q[1] & 1'b0);
        for (int i = 1; i < 511; i++) begin
            q_next[i] = (q[i+1] & q[i]) | (q[i] & ~q[i-1]) | (q[i+1] & ~q[i-1]);
        end
        q_next[511] = (1'b0 & q[511]) | (q[511] & ~q[510]) | (1'b0 & ~q[510]);
    end

    always @(posedge clk) begin
        if (rst) begin
            q <= 512'b0;
        end else if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end

endmodule