module dual_edge_capture (
    input logic clk,
    input logic d,
    output logic q
);

    always @(clk) begin
        if (clk) begin
            q <= d; // Capture on rising edge
        end else begin
            q <= d; // Capture on falling edge
        end
    end

endmodule