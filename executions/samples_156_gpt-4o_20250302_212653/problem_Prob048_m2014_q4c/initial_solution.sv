module TopModule (
    input logic clk,  // 1-bit clock signal, active edge not specified yet
    input logic d,    // 1-bit data input
    input logic r,    // 1-bit active high synchronous reset
    output logic q    // 1-bit data output
);

    always @(posedge clk) begin
        if (r) begin
            q <= 1'b0;  // Reset output to 0
        end else begin
            q <= d;     // Capture data input
        end
    end

endmodule