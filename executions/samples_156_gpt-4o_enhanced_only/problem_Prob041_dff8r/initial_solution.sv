module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 8'b0000_0000; // Reset all bits of q to zero
        end else begin
            q <= d; // Capture the input data d
        end
    end

endmodule