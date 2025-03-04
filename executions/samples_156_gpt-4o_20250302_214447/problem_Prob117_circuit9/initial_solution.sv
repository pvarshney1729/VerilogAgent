module TopModule (
    input logic clk,
    input logic rst,  // Synchronous reset
    input logic a,
    output logic [2:0] q
);

    always @(posedge clk) begin
        if (rst) begin
            q <= 3'b000;
        end else if (a == 1'b0) begin
            q <= q + 1;
        end
    end

endmodule