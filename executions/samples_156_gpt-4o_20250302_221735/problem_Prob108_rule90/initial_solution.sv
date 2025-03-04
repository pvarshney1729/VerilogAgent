module TopModule (
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[0] <= q[1] ^ 1'b0; // Left neighbor of q[0] is zero
            q[511] <= 1'b0 ^ q[510]; // Right neighbor of q[511] is zero
            for (int i = 1; i < 511; i = i + 1) begin
                q[i] <= q[i-1] ^ q[i+1];
            end
        end
    end

endmodule