module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b0; // Initialize to zero on reset
        end else begin
            q <= d; // Assign d to q in the else clause
        end
    end

endmodule