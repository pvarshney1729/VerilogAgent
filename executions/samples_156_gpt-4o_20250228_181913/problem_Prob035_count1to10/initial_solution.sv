module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // reset to 1
    end else if (q == 4'b1010) begin
        q <= 4'b0001; // wrap around to 1 after reaching 10
    end else begin
        q <= q + 1'b1; // increment counter
    end
end

endmodule