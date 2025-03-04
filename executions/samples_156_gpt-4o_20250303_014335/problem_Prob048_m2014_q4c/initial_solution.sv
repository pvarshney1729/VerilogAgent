module TopModule (
    input logic clk,
    input logic d,
    input logic r,
    output logic q
);

    always_ff @(posedge clk) begin
        if (r) begin
            q <= 1'b0; // Reset output
        end else begin
            q <= d;    // Capture input
        end
    end

endmodule