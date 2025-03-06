module TopModule (
    input clk,
    input a,
    output reg [2:0] q
);

initial begin
    q = 3'b000;
end

always @(posedge clk) begin
    if (a) begin
        q <= 3'b100;
    end else begin
        if (q == 3'b110) 
            q <= 3'b000;
        else
            q <= q + 1;
    end
end

endmodule