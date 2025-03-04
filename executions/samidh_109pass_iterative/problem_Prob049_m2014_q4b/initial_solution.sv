module TopModule (
    input logic clk,    // 1-bit clock signal
    input logic ar,     // 1-bit asynchronous reset signal, active high
    input logic d,      // 1-bit data input
    output logic q      // 1-bit output
);

    always_ff @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0;  // Reset output to 0 when asynchronous reset is high
        end else begin
            q <= d;     // On clock edge, update output to match input d
        end
    end

endmodule