module counter (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Declare 'q' as a reg
    reg [3:0] q;

    // Initial block to set 'q' upon instantiation
    initial begin
        q = 4'b0000;
    end

    // Always block for synchronous reset and counting
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset condition has priority
        end else begin
            q <= q + 1; // Normal counting behavior
        end
    end

endmodule