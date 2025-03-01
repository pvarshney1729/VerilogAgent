module TopModule (
    input logic clk,  // Clock input
    input logic ar,   // Asynchronous reset, active high
    input logic d,    // Data input
    output logic q    // Data output
);

always_ff @(posedge clk or posedge ar) begin
    if (ar) begin
        q <= 1'b0;  // Reset output to 0
    end else begin
        q <= d;     // Capture data input
    end
end

endmodule