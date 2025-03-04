module TopModule (
    input logic clk,
    input logic rst_n, // Asynchronous active-low reset
    input logic [7:0] d,
    output logic [7:0] q
);

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 8'b0; // Reset state
    else
        q <= d; // Capture input
end

endmodule