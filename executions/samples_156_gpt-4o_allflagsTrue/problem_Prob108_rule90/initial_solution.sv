module TopModule(
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] q_next;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q_next[0] <= q[1]; // q[-1] is 0
            q_next[511] <= q[510]; // q[512] is 0
            for (int i = 1; i < 511; i++) begin
                q_next[i] <= q[i-1] ^ q[i+1];
            end
            q <= q_next;
        end
    end

endmodule