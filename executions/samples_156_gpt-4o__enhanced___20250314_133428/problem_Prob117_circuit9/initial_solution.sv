module TopModule (
    input logic clk,
    input logic a,
    input logic reset,
    output logic [2:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 3'b000; // Initial state
    end else begin
        if (a) begin
            q <= 3'b100; // Hold at 4 when a is 1
        end else begin
            q <= q + 1; // Increment when a is 0
        end
    end
end

endmodule