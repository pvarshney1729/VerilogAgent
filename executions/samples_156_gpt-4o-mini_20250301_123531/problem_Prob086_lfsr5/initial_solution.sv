module TopModule (
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001;
    end else begin
        q[4] <= q[0] ^ q[4] ^ q[2];
        q[3:0] <= q[4:1];
    end
end

endmodule