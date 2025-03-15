module TopModule(
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    always_ff @(posedge clk) begin
        if (a) begin
            q <= 3'b100; // Set q to 4 when a is 1
        end else begin
            q <= q + 1;  // Increment q when a is 0
        end
    end

endmodule