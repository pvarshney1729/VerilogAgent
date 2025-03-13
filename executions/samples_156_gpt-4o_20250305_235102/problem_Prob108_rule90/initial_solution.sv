module TopModule (
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] next_q;

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            next_q[0] <= q[1] ^ 1'b0;
            next_q[511] <= 1'b0 ^ q[510];
            for (int i = 1; i < 511; i++) begin
                next_q[i] <= q[i-1] ^ q[i+1];
            end
            q <= next_q;
        end
    end

endmodule