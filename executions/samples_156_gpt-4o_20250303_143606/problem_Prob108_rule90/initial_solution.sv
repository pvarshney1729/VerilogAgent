module TopModule (
    input logic clk,
    input logic reset_n,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 512'b0;
        end else if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 512; i++) begin
                q[i] <= (i == 0) ? q[i+1] : (i == 511) ? q[i-1] : q[i-1] ^ q[i+1];
            end
        end
    end

endmodule