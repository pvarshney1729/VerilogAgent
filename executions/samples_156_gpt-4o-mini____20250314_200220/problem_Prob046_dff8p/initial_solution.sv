module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    logic [7:0] ff;

    always @(negedge clk) begin
        if (reset) begin
            ff <= 8'h34; // Reset to 0x34
        end else begin
            ff <= d; // Capture input d
        end
    end

    assign q = ff; // Output the value of the flip-flops

endmodule