module TopModule (
    input wire clk,
    input wire reset_n,
    input wire load,
    input wire [511:0] data,
    output reg [511:0] q
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        q <= 512'b0;
    end else if (load) begin
        q <= data;
    end else begin
        integer i;
        for (i = 0; i < 512; i = i + 1) begin
            if (i == 0) begin
                q[i] <= 0 ^ q[i+1];
            end else if (i == 511) begin
                q[i] <= q[i-1] ^ 0;
            end else begin
                q[i] <= q[i-1] ^ q[i+1];
            end
        end
    end
end

endmodule