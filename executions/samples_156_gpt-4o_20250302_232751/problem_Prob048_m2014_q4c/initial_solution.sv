module TopModule (
    input  wire clk,     // Clock input, triggers on the positive edge
    input  wire d,       // Data input, captured on clock edge
    input  wire r,       // Active-high synchronous reset input
    output reg  q        // Data output, follows data input when not reset
);

    always @(posedge clk) begin
        if (r) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule