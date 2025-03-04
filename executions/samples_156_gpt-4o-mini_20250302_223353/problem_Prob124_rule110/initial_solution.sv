module TopModule (
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] next_q;

    always @(*) begin
        next_q[0] = (q[1] & q[0]) | (q[1] & ~q[0]) | (~q[1] & q[0]);
        for (int i = 1; i < 511; i++) begin
            next_q[i] = (q[i+1] & q[i]) | (q[i+1] & ~q[i]) | (~q[i+1] & q[i]);
        end
        next_q[511] = (q[510] & q[511]) | (q[510] & ~q[511]) | (~q[510] & q[511]);
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule