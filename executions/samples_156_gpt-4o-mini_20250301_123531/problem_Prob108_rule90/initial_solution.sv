module TopModule (
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 512; i++) begin
                if (i == 0) begin
                    q[i] <= 1'b0 ^ q[i + 1];
                end else if (i == 511) begin
                    q[i] <= q[i - 1] ^ 1'b0;
                end else begin
                    q[i] <= q[i - 1] ^ q[i + 1];
                end
            end
        end
    end

endmodule