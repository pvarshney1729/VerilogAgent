module TopModule (
    input wire clk,
    input wire d,
    input wire r,
    output reg q
);
    always @(posedge clk) begin
        if (r) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule