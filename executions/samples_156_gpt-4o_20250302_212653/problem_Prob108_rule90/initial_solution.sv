module TopModule (
    input logic clk,
    input logic rst_n,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q <= 512'b0;
        end else if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 512; i++) begin
                if (i == 0) begin
                    q[i] <= q[i+1];
                end else if (i == 511) begin
                    q[i] <= q[i-1];
                end else begin
                    q[i] <= q[i-1] ^ q[i+1];
                end
            end
        end
    end

endmodule