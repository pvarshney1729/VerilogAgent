[BEGIN]
module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

always @(posedge clk) begin
    if (a == 1'b1) begin
        q <= 1'b1; // Set q to 1 if a is high
    end else begin
        q <= 1'b0; // Set q to 0 if a is low
    end
end

initial begin
    q = 1'b0; // Initial state of output `q`
end

endmodule
[DONE]